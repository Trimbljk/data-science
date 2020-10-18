FROM jupyter/datascience-notebook:610bb8b938db

USER $NB_USER

RUN pip install --ignore-installed pyathena==1.11.2 \
	&& pip install --ignore-installed awscli==1.16.128 \
	&& pip install --ignore-installed boto3==1.9.219 \
	&& pip install --upgrade requests

