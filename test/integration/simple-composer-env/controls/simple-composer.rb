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
    title "Simple Cloud Composer"

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
end
