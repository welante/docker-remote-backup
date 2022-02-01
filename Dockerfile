FROM jobber:latest

ENV HOME "/home/jobberuser"
ENV JOBFILE "${HOME}/.jobber"
ENV PRIVAT_KEY "${HOME}/.ssh/id_rsa"
ENV LOCAL_DIR "/dst/"
ENV REMOTE_HOST ""
ENV REMOTE_DIR ""
ENV DELETE_REMOTE ""
ENV RSYNC_OPTIONS "-av"

USER root

RUN apk update && apk add openssh-client rsync bash

COPY --chown=jobberuser:jobberuser jobfile ${JOBFILE}
COPY --chown=jobberuser:jobberuser rsync.sh /home/jobberuser/rsync.sh

RUN mkdir ${LOCAL_DIR} && chown jobberuser:jobberuser ${LOCAL_DIR}

USER jobberuser

WORKDIR ${HOME}

RUN mkdir -p ${HOME}/.ssh/ && chmod 700 ${HOME}/.ssh/
