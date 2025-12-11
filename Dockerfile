FROM python:3.10-slim
COPY requirements.txt /tmp/requirements.txt
RUN pip install -U pip setuptools wheel && pip install -r /tmp/requirements.txt
WORKDIR /app
COPY . /app/
CMD ["python", "train.py"]
