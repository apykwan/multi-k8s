docker build -t apkwan/multi-client:latest -t apkwan/multi-client:$SHA -f ./client/Dockerfile -f ./client
docker build -t apkwan/multi-server:latest -t apkwan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t apkwan/multi-worker:latest -t apkwan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push apkwan/multi-client:latest
docker push apkwan/multi-server:latest
docker push apkwan/multi-worker:latest

docker push apkwan/multi-client:$SHA
docker push apkwan/multi-server:$SHA
docker push apkwan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=apkwan/multi-server:$SHA
kubectl set image deployments/client-deployment client=apkwan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=apkwan/multi-worker:$SHA