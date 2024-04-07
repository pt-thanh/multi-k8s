docker build -t ptthanh/multi-client:latest -t ptthanh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ptthanh/multi-server:latest -t ptthanh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ptthanh/multi-worker:latest -t ptthanh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ptthanh/multi-client:latest
docker push ptthanh/multi-server:latest
docker push ptthanh/multi-worker:latest

docker push ptthanh/multi-client:$SHA
docker push ptthanh/multi-server:$SHA
docker push ptthanh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ptthanh/multi-server:$SHA
kubectl set image deployments/client-deployment client=ptthanh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ptthanh/multi-worker:$SHA