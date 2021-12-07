# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This changelog is generated automatically based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

## [2.2.0](https://www.github.com/terraform-google-modules/terraform-google-composer/compare/v2.1.0...v2.2.0) (2021-11-24)


### Features

* update TPG version constraints to allow 4.0 ([#27](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/27)) ([759bcb9](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/759bcb991d5917858717906acfd2e05f9d042891))

## [2.1.0](https://www.github.com/terraform-google-modules/terraform-google-composer/compare/v2.0.0...v2.1.0) (2021-10-19)


### Features

* add allowed_ip_ranges variable ([#21](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/21)) ([b91c587](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/b91c587706abd8f22d03976fff1c03cdef6d7d10))

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-composer/compare/v1.0.0...v2.0.0) (2021-06-22)


### ⚠ BREAKING CHANGES

* `create_environment` submodule now uses the `google-beta` provider.

### Features

* Add CMEK support to create_environment submodule by setting `kms_key_name` variable ([#16](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/16)) ([9cd4934](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/9cd4934e5803318430d46b2f05810581a2400819))

## [1.0.0](https://www.github.com/terraform-google-modules/terraform-google-composer/compare/v0.1.1...v1.0.0) (2021-04-01)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#11)

### Features

* add Terraform 0.13 constraint and module attribution ([#11](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/11)) ([d45205e](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/d45205e33e62ad43fe4ead09d9a1c54cd5716488))
* Composer module improvement ([#12](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/12)) ([549ba62](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/549ba6224c3e015028bffbf7fd204313179022d9))

### [0.1.1](https://www.github.com/terraform-google-modules/terraform-google-composer/compare/v0.1.0...v0.1.1) (2020-11-23)


### Bug Fixes

* Correction on usage parameters ([#4](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/4)) ([bd1a9ec](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/bd1a9ec24a20fdb3825faa97d6a677a13aa04c0d))
* pin CI images ([#5](https://www.github.com/terraform-google-modules/terraform-google-composer/issues/5)) ([499c4db](https://www.github.com/terraform-google-modules/terraform-google-composer/commit/499c4db3c9450ff5f93c2eb7f6e1b69aaac9c024))

## [0.1.0](https://github.com/terraform-google-modules/terraform-google-composer/releases/tag/v0.1.0) - 2020-06-23

### Features

- Initial release

[0.1.0]: https://github.com/terraform-google-modules/terraform-google-composer/releases/tag/v0.1.0
