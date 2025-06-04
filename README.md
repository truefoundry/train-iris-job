Train Iris Classification Model
---
This example trains an Iris Classification model

## Run Locally

1. Install requirements

```shell
python -m pip install -r requirements.txt
```

2. Run the training script

```shell
python train.py
```

## Deploy with TrueFoundry

1. Install `truefoundry`

```shell
python -m pip install -U truefoundry
```

2. Login

```shell
tfy login --host <TrueFoundry Platform URL>
```

1. Add a deploy.py

- Edit your `workspace_fqn` ([Docs](https://docs.truefoundry.com/docs/key-concepts#get-workspace-fqn))

```python
import logging
import argparse

from truefoundry.deploy import (
    Build,
    DockerFileBuild,
    Image,
    LocalSource,
    Port,
    PythonBuild,
    Job,
    Resources
)

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

job = Job(
    name="train-iris-job",

    # --- Build configuration i.e. How to package and build source code ---

    # This will instruct Truefoundry to automatically generate the Dockerfile and build it
    image=Build(
        build_source=LocalSource(local_build=False),
        build_spec=PythonBuild(
            requirements_path="requirements.txt",
            command="python train.py"
        )
        # Alternatively, you can also use DockerFileBuild to use the written Dockerfile like follows:
        # build_spec=DockerFileBuild()
    ),
    # Alternatively, you can use an already built public image of this codebase like follows:
    # image=Image(image_uri="...")

    # --- Environment Variables ---
    env={},

    # --- Resources ---
    resources=Resources(
        cpu_request=0.5, 
        cpu_limit=0.5,
        memory_request=1000, 
        memory_limit=1000,
        ephemeral_storage_request=500, 
        ephemeral_storage_limit=500
    ),
    workspace_fqn="<Enter Workspace FQN>",
)

# Get your workspace fqn from https://docs.truefoundry.com/docs/workspace#copy-workspace-fqn-fully-qualified-name
job.deploy(workspace_fqn="<Enter Workspace FQN>", wait=False)
```

4. Deploy!

```shell
python deploy.py
```
