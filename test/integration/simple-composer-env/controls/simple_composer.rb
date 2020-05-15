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

        describe "composer_environment" do
            it "have name" do
                expect(data["name"]).to include("projects/#{attribute("project_id")}/locations/us-central1/environments/#{attribute("composer_env_name")}")
            end
        end
    end
end
