BigQuery Emulator Docker Container
---

BigQuery Emulator  
https://github.com/goccy/bigquery-emulator

## Getting Started

Start BigQuery Emulator Container.

```sh
docker pull ghcr.io/takemikami/bigquery-emulator-container:latest
docker run -e PROJECT=foo-project -p 9050:9050 -p 9060:9060 -t ghcr.io/takemikami/bigquery-emulator-container:latest
```

Execute Query.

```sh
$ bq --api http://127.0.0.1:9050 query --project_id=foo-project "select 1 as x"
+---+
| x |
+---+
| 1 |
+---+
```

## Service on GitHub Actions

.github/workflows/ci.yaml

```yaml
name: ci
on: push
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      bigquery:
        image: ghcr.io/takemikami/bigquery-emulator-container:latest
        ports:
          - 9050:9050
          - 9060:9060
        env:
          PROJECT: foo
          DATASET: bar
    steps:
      - uses: actions/setup-python@v5
      - run: pip install google-cloud-bigquery
      - run: |
          echo '
          from google.auth.credentials import AnonymousCredentials
          from google.api_core import client_info, client_options
          import google.cloud.bigquery
          client = google.cloud.bigquery.Client(
              "foo",
              AnonymousCredentials(),
              location=None,
              client_info=client_info.ClientInfo(),
              client_options=client_options.ClientOptions(api_endpoint="http://127.0.0.1:9050")
          )
          rtn = client.query(query="select 1 as x")
          print([e for e in rtn.result()])
          ' | python
```
