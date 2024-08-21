-include .env

<<<<<<< HEAD
build:
	forge build
=======
build:; forge build
>>>>>>> 11cdca577ffc7178abf8e6dbb96f691248f45a0d

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv