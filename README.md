### example docker compose usage
```
services:
  lagrange-milky:
    image: ghcr.io/itzdrli/lagrange-milky-docker:latest 
    container_name: lagrange-milky
    restart: unless-stopped
    volumes:
      - ./data:/lagrange
    dns:                        # optional, depending on your machine network
      - 8.8.8.8
      - 9.9.9.9
```