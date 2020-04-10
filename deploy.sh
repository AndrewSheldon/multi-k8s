docker build -t provardis2020/multi-client:latest -t provardis2020/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t provardis2020/multi-server:latest -t provardis2020/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t provardis2020/multi-worker:latest -t provardis2020/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push provardis2020/multi-client:latest
docker push provardis2020/multi-server:latest
docker push provardis2020/multi-worker:latest

docker push provardis2020/multi-client:$SHA
docker push provardis2020/multi-server:$SHA
docker push provardis2020/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=provardis2020/multi-server:$SHA
kubectl set image deployments/client-deployment client=provardis2020/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=provardis2020/multi-worker:$SHA
