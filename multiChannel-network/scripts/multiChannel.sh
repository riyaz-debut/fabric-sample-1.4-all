
####################################################################################


echo "generate the required crypto material for organizations"
../bin/cryptogen generate --config=./crypto-config.yaml

export FABRIC_CFG_PATH=$PWD

echo "generate the channel artifacts"
../bin/configtxgen -profile ThreeOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

echo ""
export CHANNEL_ONE_NAME=mychannel  && ../bin/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME

echo ""
export CHANNEL_TWO_NAME=abchannel  && ../bin/configtxgen -profile ABOrgsChannel -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME

echo ""
export CHANNEL_THREE_NAME=bcchannel  && ../bin/configtxgen -profile BCOrgsChannel -outputCreateChannelTx ./channel-artifacts/${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME

echo ""
export CHANNEL_FOUR_NAME=acchannel  && ../bin/configtxgen -profile ACOrgsChannel -outputCreateChannelTx ./channel-artifacts/${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME

echo "Successfully define the anchor peer for Channel 1 on the channel that we are constructing"
../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg TcsMSP
../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg WiproMSP
../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg NagarroMSP

echo "Successfully define the anchor peer for Channel 2 on the channel that we are constructing"
../bin/configtxgen -profile ABOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg TcsMSP
../bin/configtxgen -profile ABOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg WiproMSP

echo "Successfully define the anchor peer for Channel 3 on the channel that we are constructing"
../bin/configtxgen -profile BCOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg WiproMSP
../bin/configtxgen -profile BCOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg NagarroMSP

echo "Successfully define the anchor peer for Channel 4 on the channel that we are constructing"
../bin/configtxgen -profile ACOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME -asOrg TcsMSP
../bin/configtxgen -profile ACOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors_${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME -asOrg NagarroMSP

echo "Successfully up the network network"
docker-compose -f docker-compose-cli.yaml up -d

echo "enter to cli container"
docker exec -it cli bash

env for org 2
env for org 3

echo "============= create and join channel for channel 1 mychannel ========================================"
echo "=================for org 1(tcs) ============================="
export CHANNEL_ONE_NAME=mychannel

peer channel create -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f ./channel-artifacts/mychannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b mychannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f ./channel-artifacts/TcsMSPanchors_mychannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "=================for org 2(wipro) ============================="
echo "============= set env variable for Org2(wipro) ================"
peer channel join -b mychannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f ./channel-artifacts/WiproMSPanchors_mychannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "=================for org 3(nagarro) ============================="
echo "============= set env variable for Org3(nagarro) ================"
peer channel join -b mychannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_ONE_NAME -f ./channel-artifacts/NagarroMSPanchors_mychannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "============= create and join channel for channel 2 abchannel ========================================"
echo "=================for org 1(tcs) ============================="
echo "============= set env variable again for Org1(tcs) ================"
export CHANNEL_TWO_NAME=abchannel

peer channel create -o orderer.example.com:7050 -c $CHANNEL_TWO_NAME -f ./channel-artifacts/abchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b abchannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_TWO_NAME -f ./channel-artifacts/TcsMSPanchors_abchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "=================for org 2(wipro) ============================="
echo "============= set env variable for Org2(wipro) ================"

peer channel join -b abchannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_TWO_NAME -f ./channel-artifacts/WiproMSPanchors_abchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "============= create and join channel for channel 3 bcchannel ========================================"
echo "=================for org 1(wipro) ============================="
echo "============= set env variable again for Org1(wipro) ================"
export CHANNEL_THREE_NAME=bcchannel

peer channel create -o orderer.example.com:7050 -c $CHANNEL_THREE_NAME -f ./channel-artifacts/bcchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b bcchannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_THREE_NAME -f ./channel-artifacts/WiproMSPanchors_bcchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "=================for org 2(nagarro) ============================="
echo "============= set env variable for Org2(nagarro) ================"
peer channel join -b bcchannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_THREE_NAME -f ./channel-artifacts/NagarroMSPanchors_bcchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "============= create and join channel for channel 4 acchannel ========================================"
echo "=================for org 1(tcs) ============================="
echo "============= set env variable again for Org1(tcs) ================"
export CHANNEL_FOUR_NAME=acchannel

peer channel create -o orderer.example.com:7050 -c $CHANNEL_FOUR_NAME -f ./channel-artifacts/acchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b acchannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_FOUR_NAME -f ./channel-artifacts/TcsMSPanchors_acchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "=================for org 2(nagarro) ============================="
echo "============= set env variable for Org2(nagarro) ================"
peer channel join -b acchannel.block

peer channel update -o orderer.example.com:7050 -c $CHANNEL_FOUR_NAME -f ./channel-artifacts/NagarroMSPanchors_acchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo " check the list of joined channel"
peer channel list

echo "deployed chaincode on the diffenet channel"
peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go/

echo "Instantiate and Interact with Chaincode"
peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C $CHANNEL_ONE_NAME -n mycc -v 1.0 -c '{"Args":["init","a", "100", "b","200", "c", "300"]}' -P "AND ('TcsMSP.peer','WiproMSP.peer','NagarroMSP.peer')"

echo "query from the particular chaincode"
peer chaincode query -C $CHANNEL_ONE_NAME -n mycc -c '{"Args":["query","a"]}'

echo "invoke query"
peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C $CHANNEL_ONE_NAME -n mycc --peerAddresses peer0.tcs.example.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/tcs.example.com/peers/peer0.tcs.example.com/tls/ca.crt --peerAddresses peer0.wipro.example.com:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/wipro.example.com/peers/peer0.wipro.example.com/tls/ca.crt -c '{"Args":["invoke","a","b","10"]}'

