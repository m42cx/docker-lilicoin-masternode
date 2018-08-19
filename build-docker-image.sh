#!/bin/bash
set -x

NAMESPACE="guggero"
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

function build {
  COMPONENT=$1
  VERSION=0.12.2.4
  echo "Building $COMPONENT with version $VERSION"
  docker build --build-arg VERSION=$VERSION -t $NAMESPACE/$COMPONENT-pterodactyl -t $NAMESPACE/$COMPONENT-pterodactyl:$VERSION .
  docker push $NAMESPACE/$COMPONENT-pterodactyl
  docker push $NAMESPACE/$COMPONENT-pterodactyl:$VERSION
}

build terracoin
