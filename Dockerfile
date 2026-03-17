FROM rocm/pytorch:rocm7.2_ubuntu24.04_py3.12_pytorch_release_2.7.1

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-lc"]

# System deps
RUN apt-get update && apt-get install -y \
    git ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# -------------------------
# Install CTranslate2 ROCm wheel
# -------------------------
RUN pip install --find-links https://github.com/OpenNMT/CTranslate2/releases/expanded_assets/v4.7.1 \
    ctranslate2

# -------------------------
# Install Wyoming Whisper
# -------------------------
RUN git clone https://github.com/rhasspy/wyoming-faster-whisper.git && \
    cd wyoming-faster-whisper && \
    pip install .

# -------------------------
# Runtime script
# -------------------------
COPY docker_run.sh /usr/local/bin/docker_run.sh
RUN chmod +x /usr/local/bin/docker_run.sh

EXPOSE 10300
VOLUME ["/data"]

ENTRYPOINT ["/usr/local/bin/docker_run.sh"]
CMD ["--model", "medium.en"]