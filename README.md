# PeerDB Google Cloud Docker Compose Setup

This repository provides a Docker Compose setup to run [PeerDB](https://github.com/PeerDB-io/peerdb) in a Google Cloud environment, including support for private IP access using GCP's internal DNS resolver.

## Repository Structure

- `peerdb-base/`: Git submodule pointing to the official PeerDB repository.
- `docker-compose.gc.yml`: Compose override that adds DNS resolver for GCP networking.
- `.env.sample`: Sample environment config.
- `Makefile`: Shortcuts for Docker Compose tasks.
- `nginx.conf`: Template for Nginx config.
- `setup-nginx.sh`: Script to configure Nginx as a reverse proxy.

---

## Quick Start

### 1. Clone the repo with submodules

```bash
git clone --recurse-submodules https://github.com/ali-avani/peerdb-google-cloud.git
cd peerdb-google-cloud
```

If you forgot `--recurse-submodules`, you can run:

```bash
git submodule update --init --recursive
```

---

### 2. Create your `.env` file

```bash
cp .env.sample .env
```

You can edit `.env` if needed, but `169.254.169.254` should work on most GCP VMs.

---

### 3. Start PeerDB with GCP DNS config

```bash
make up
```

This runs `peerdb-base/docker-compose.yml` extended by `docker-compose.gc.yml` to enable DNS resolution of internal IPs (e.g. `postgres.internal`).

---

### 4. Set up Nginx as reverse proxy (optional)

To serve PeerDB UI on a custom domain:

```bash
chmod +x setup-nginx.sh
./setup-nginx.sh
```

This script will:

- Ask for your desired domain (e.g. `peerdb.example.com`)
- Install Nginx if not already installed
- Replace `DOMAIN_PLACEHOLDER` in `nginx.conf` with your domain
- Place the config into `/etc/nginx/sites-available/peerdb`
- Enable the site and reload Nginx

After completion, visit your domain (e.g., `http://peerdb.example.com`) to access PeerDB UI.

---

## Common Commands

```bash
make down      # stop and remove containers
make logs      # view logs
make config    # show merged docker config
make ps        # list running services
make nuke      # remove all containers and volumes (careful!)
```

---

## Test DNS Resolution

Once services are up:

```bash
docker exec -it peerdb-server sh
nslookup postgres.internal
```

You should see your internal IP (e.g. `10.115.128.2`) if everything's working.

---

## License

This repo follows the [PeerDB license](https://github.com/PeerDB-io/peerdb/blob/main/LICENSE).
