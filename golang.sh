#!/usr/bin/env bash
packages=(
    "github.com/github/hub"
    "github.com/junegunn/fzf"
    "github.com/GoogleCloudPlatform/container-diff"
    "github.com/jessfraz/dockfmt"
    "github.com/alecthomas/gometalinter"
    "github.com/davidrjenni/reftools/cmd/fillstruct"
    "github.com/dominikh/go-tools/cmd/keyify"
    "github.com/fatih/gomodifytags"
    "github.com/fatih/motion"
    "github.com/golang/lint/golint"
    "github.com/josharian/impl"
    "github.com/jstemmer/gotags"
    "github.com/kisielk/errcheck"
    "github.com/klauspost/asmfmt/cmd/asmfmt"
    "github.com/nsf/gocode"
    "github.com/rogpeppe/godef"
    "github.com/zmb3/gogetdoc"
    "golang.org/x/tools/cmd/goimports"
    "golang.org/x/tools/cmd/gorename"
    "golang.org/x/tools/cmd/guru"
    "github.com/gsamokovarov/jump"
    "github.com/golang/dep/cmd/dep"
)

for package in "${packages[@]}"
do
    echo "Install/Upgrade ${package}"
    go get -u  $package && go install $package
done
