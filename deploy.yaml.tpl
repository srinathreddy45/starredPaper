apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-cloudbuild
  labels:
    app: hello-cloudbuild
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello-cloudbuild
  template:
    metadata:
      labels:
        app: hello-cloudbuild
    spec:
      containers:
      - name: hello-cloudbuild
        image: gcr.io/GOOGLE_CLOUD_PROJECT/apacheimage:COMMIT_SHA
        ports:
        - containerPort: 80
      tolerations:
      - key: "cpu_num"
        operator: "Equal"
        value: "2"
        effect: "NoSchedule"
---
kind: Service
apiVersion: v1
metadata:
  name: hello-cloudbuild
spec:
  selector:
    app: hello-cloudbuild
  ports:
  - protocol: TCP
    port: 9000
    targetPort: 80
  type: LoadBalancer
