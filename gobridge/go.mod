module github.com/mysteriumnetwork/fff

go 1.16

require (
	code.cloudfoundry.org/archiver v0.0.0-20220328120804-99329f9bbb8b // indirect
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/mysteriumnetwork/myst-launcher v0.0.0
	github.com/sirupsen/logrus v1.8.1 // indirect
)

replace github.com/mysteriumnetwork/myst-launcher => ../../myst-launcher
