// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package simple_composer_env_v3

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSimpleComposerEnvV3Module(t *testing.T) {
	composer := tft.NewTFBlueprintTest(t)

	composer.DefineVerify(func(assert *assert.Assertions) {
		composer.DefaultVerify(assert)

		projectID := composer.GetStringOutput("project_id")

		op := gcloud.Runf(t, "composer environments describe %s --project=%s --location=us-central1", composer.GetStringOutput("composer_env_name"), projectID)
		assert.Equal(fmt.Sprintf("projects/%s/locations/us-central1/environments/%s", projectID, composer.GetStringOutput("composer_env_name")), op.Get("name").String(), "Composer name is valid")
		assert.Equal(composer.GetStringOutput("airflow_uri"), op.Get("config.airflowUri").String(), "AirflowUri is valid")
		assert.Equal(composer.GetStringOutput("gcs_bucket"), op.Get("config.dagGcsPrefix").String(), "GCS-Dag is valid")
	})
	composer.Test()
}
