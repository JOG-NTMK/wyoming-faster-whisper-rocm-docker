# Wyoming Faster Whisper (ROCm Docker)

This repository provides a Dockerized version of [wyoming-faster-whisper](https://github.com/rhasspy/wyoming-faster-whisper) with **ROCm support** for AMD GPUs. It allows you to run a high-performance speech-to-text server that integrates with the Wyoming protocol.

## Purpose

The main goal is to leverage AMD's ROCm platform to accelerate whisper-based transcription in environments that use the Wyoming protocol (like Home Assistant).

## How to use

### Docker Compose

1.  Clone the repository.
2.  Run the following command to start the container:
    ```bash
    docker compose up -d
    ```

### Docker Run (Directly)

```bash
docker build -t wyoming-faster-whisper-rocm .
docker run -it --rm \
  --device /dev/kfd --device /dev/dri \
  --group-add video \
  --ipc=host \
  --security-opt seccomp=unconfined \
  -p 10300:10300 \
  -v ./data:/data \
  wyoming-faster-whisper-rocm \
  --model medium.en --language en
```

## Parameters

You can pass several parameters to the container to customize the behavior of the Whisper model. These parameters are passed directly to `wyoming-faster-whisper`.

### Common Parameters

| Parameter | Description | Default (in `docker-compose.yml`) |
| :--- | :--- | :--- |
| `--model` | The name of the Faster-Whisper model to use (e.g., `tiny`, `base`, `small`, `medium`, `large-v3`, `distil-medium.en`). | `medium.en` |
| `--language` | The language for transcription (e.g., `en`, `de`, `fr`). | `en` |
| `--beam-size` | Beam size for decoding. Higher values are more accurate but slower. | `5` |

For a full list of parameters, you can check the [wyoming-faster-whisper documentation](https://github.com/rhasspy/wyoming-faster-whisper).
