#!/usr/bin/env bash
packages=(
    "github.com/github/hub/..."
    "github.com/junegunn/fzf/..."
    "github.com/GoogleCloudPlatform/container-diff/..."
    "github.com/jessfraz/dockfmt/..."
    "github.com/golangci/golangci-lint/cmd/golangci-lint"
    "github.com/davidrjenni/reftools/cmd/fillstruct/..."
    "github.com/dominikh/go-tools/cmd/keyify/..."
    "github.com/fatih/gomodifytags/..."
    "github.com/fatih/motion/..."
    "github.com/golang/lint/golint/..."
    "github.com/josharian/impl/..."
    "github.com/jstemmer/gotags/..."
    "github.com/kisielk/errcheck/..."
    "github.com/klauspost/asmfmt/cmd/asmfmt/..."
    "github.com/stamblerre/gocode/..."
    "github.com/rogpeppe/godef/..."
    "github.com/zmb3/gogetdoc/..."
    "golang.org/x/tools/cmd/goimports/..."
    "golang.org/x/tools/cmd/gorename/..."
    "golang.org/x/tools/cmd/guru/..."
    "github.com/gsamokovarov/jump/..."
    "github.com/golang/dep/cmd/dep/..."
    "github.com/uudashr/gopkgs/cmd/gopkgs"
    "github.com/ramya-rao-a/go-outline/..."
    "github.com/acroca/go-symbols/..."
    "github.com/cweill/gotests/..."
    "github.com/haya14busa/goplay/cmd/goplay"
    "github.com/godoctor/godoctor"
    "github.com/go-delve/delve/cmd/dlv@latest"
    "github.com/sqs/goreturns@latest"
)

for package in "${packages[@]}"
do
    echo "Install/Upgrade ${package}"
    go install $package
done
