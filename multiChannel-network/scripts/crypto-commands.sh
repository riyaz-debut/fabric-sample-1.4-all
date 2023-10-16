#!/bin/bash
#
# commands to generate crypto material
# Then, we’ll invoke the configtxgen tool to create the orderer genesis block
# Next, we need to create the channel transaction artifact
# Next, we will define the anchor peer for Org1 on the channel that we are constructing.
# Now, we will define the anchor peer for Org2 on the same channel
# 
#

echo "Start generating crypto material"
../bin/cryptogen generate --config=./crypto-config.yaml

export FABRIC_CFG_PATH=$PWD
echo "Successfully set the path for genesis block"

# ../bin/configtxgen -profile ThreeOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
# ../bin/configtxgen -profile ABOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
# ../bin/configtxgen -profile BCOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
# ../bin/configtxgen -profile ACOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
# echo "Successfully invoke the configtxgen tool to create the orderer genesis block"

# #../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME

# export CHANNEL_NAME=mychannel  && ../bin/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
# export CHANNEL_NAME=abchannel  && ../bin/configtxgen -profile ABOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
# export CHANNEL_NAME=bcchannel  && ../bin/configtxgen -profile BCOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
# export CHANNEL_NAME=acchannel  && ../bin/configtxgen -profile ACOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
# echo "Successfully create the channels transaction artifact"

# #../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg TcsMSP

# ../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors.tx -channelID $CHANNEL_NAME -asOrg TcsMSP
# ../bin/configtxgen -profile ABOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors.tx -channelID $CHANNEL_NAME -asOrg TcsMSP
# ../bin/configtxgen -profile BCOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors.tx -channelID $CHANNEL_NAME -asOrg TcsMSP
# ../bin/configtxgen -profile ACOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors.tx -channelID $CHANNEL_NAME -asOrg TcsMSP
# echo "Successfully define the anchor peer for Org1 on the channels that we are constructing"

# ../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors.tx -channelID $CHANNEL_NAME -asOrg WiproMSP
# ../bin/configtxgen -profile ABOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors.tx -channelID $CHANNEL_NAME -asOrg WiproMSP
# ../bin/configtxgen -profile BCOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors.tx -channelID $CHANNEL_NAME -asOrg WiproMSP
# ../bin/configtxgen -profile ACOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors.tx -channelID $CHANNEL_NAME -asOrg WiproMSP
# echo "Successfully define the anchor peer for Org2 on the same channels"

# ../bin/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors.tx -channelID $CHANNEL_NAME -asOrg NagarroMSP
# ../bin/configtxgen -profile ABOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors.tx -channelID $CHANNEL_NAME -asOrg NagarroMSP
# ../bin/configtxgen -profile BCOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors.tx -channelID $CHANNEL_NAME -asOrg NagarroMSP
# ../bin/configtxgen -profile ACOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors.tx -channelID $CHANNEL_NAME -asOrg NagarroMSP
# echo "Successfully define the anchor peer for Org3 on the channels that we are constructing"

# docker-compose -f docker-compose-cli.yaml up -d 
# echo "Successfully up the network network for cli command"

# docker exec -it cli bash
# echo "Successfully enter into cli container"

######################################################################################################33

../bin/configtxgen -profile ThreeOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

export CHANNEL_ONE_NAME=ThreeOrgsChannel
export CHANNEL_ONE_PROFILE=ThreeOrgsChannel
export CHANNEL_TWO_NAME=ABOrgsChannel
export CHANNEL_TWO_PROFILE=ABOrgsChannel
export CHANNEL_THREE_NAME=BCOrgsChannel
export CHANNEL_THREE_PROFILE=BCOrgsChannel
export CHANNEL_FOUR_NAME=ACOrgsChannel
export CHANNEL_FOUR_PROFILE=ACOrgsChannel


../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME
../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME
../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME
../bin/configtxgen -profile ${CHANNEL_FOUR_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME


../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg TcsMSP
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg WiproMSP
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg NagarroMSP

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg TcsMSP
../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg WiproMSP

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg WiproMSP
../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg NagarroMSP

../bin/configtxgen -profile ${CHANNEL_FOUR_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors_${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME -asOrg TcsMSP
../bin/configtxgen -profile ${CHANNEL_FOUR_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/NagarroMSPanchors_${CHANNEL_FOUR_NAME}.tx -channelID $CHANNEL_FOUR_NAME -asOrg NagarroMSP


docker-compose -f docker-compose-cli.yaml up -d 

