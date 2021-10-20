# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Cloud Composer Environment

project_id = attribute('project_id')
composer_env_name = attribute('composer_env_name')
composer_env_id = attribute('composer_env_id')
gke_cluster = attribute('gke_cluster')
gcs_bucket = attribute('gcs_bucket')
airflow_uri = attribute('airflow_uri')

control "Cloud Composer Environment" do
    title "Cloud Composer with connections"

    describe command("gcloud composer environments describe #{attribute("composer_env_name")} --location=us-central1 --project=#{attribute("project_id")} --format=json") do
        its(:exit_status) { should eq 0 }
        its(:stderr) { should eq "" }

        let!(:data) do
            if subject.exit_status == 0
                JSON.parse(subject.stdout)
            else
                {}
            end
        end

        describe "composer_environment_config" do
            it "has config" do
                config_data = data['config']
                expect(data["name"]).to include("projects/#{attribute("project_id")}/locations/us-central1/environments/#{attribute("composer_env_name")}")
                expect(config_data["gkeCluster"]). to include(attribute("gke_cluster"))
                expect(config_data["dagGcsPrefix"]). to include(attribute("gcs_bucket"))
                expect(config_data["airflowUri"]). to include(attribute("airflow_uri"))
            end
        end
    end

    # TODO: Use 'pools -- list' instead of 'pool' so it will work with Airflow v2.
    # The command is being wrongly reported as incompatible (See Google support case 29006802)
    describe command("gcloud composer environments run #{attribute("composer_env_name")} --location=us-central1 --project=#{attribute("project_id")} pool") do
        its(:exit_status) { should eq 0 }

        let!(:data) do
            if subject.exit_status == 0
                # In airflow>=2 we can run `list -o json` but let's perform regexp matches on the default human-readable table format to make it more portable
                subject.stdout
            else
                ""
            end
        end

        it "has the inline pool" do
            expect(data).to match(/.*inline-pool-1.*1111.*Inline Pool.*\n/)
        end

        it "has the standalone pool" do
            expect(data).to match(/.*standalone-pool-1.*2222.*Standalone Pool.*\n/)
        end

    end
end
