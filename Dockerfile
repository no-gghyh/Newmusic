# 
FROM python:3.13-slim

# 
WORKDIR /app

# 
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    unzip \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#
#
RUN curl -fsSL https://deno.land/install.sh -o install_deno.sh \
    && sh install_deno.sh \
    && rm install_deno.sh

# 
ENV DENO_INSTALL="/root/.deno"
ENV PATH="${DENO_INSTALL}/bin:${PATH}"

# 
COPY requirements.txt .
RUN pip3 install --no-cache-dir -U pip \
    && pip3 install --no-cache-dir -U -r requirements.txt

# 
COPY . .

# 
CMD ["bash", "start"]
