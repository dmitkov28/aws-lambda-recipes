FROM python:3.12.4-slim

WORKDIR /var/task

COPY app/requirements.txt .

RUN pip install awslambdaric && pip install -r requirements.txt

RUN pip install -r requirements.txt

COPY app .

ENTRYPOINT [ "python", "-m", "awslambdaric" ]

CMD ["main.lambda_handler"]