FROM quay.io/odh-jupyterhub/jupyterhub-img

COPY leader-wait.sh /usr/bin

RUN python3 -m pip install --no-cache-dir jupyterhub-traefik-proxy && \
  sed -i '1 a /usr/bin/leader-wait.sh' /opt/app-root/builder/run

CMD /bin/bash /opt/app-root/builder/run
