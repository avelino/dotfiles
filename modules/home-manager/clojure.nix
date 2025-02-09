{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    clojure
    babashka
    clj-kondo
    clojure-lsp
  ];

  home.file.".clojure/deps.edn".text = ''
    {
     :aliases
     {;; REPL with various tools
      :dev/repl
      {:extra-deps {org.clojure/tools.namespace {:mvn/version "RELEASE"}
                   io.github.seancorfield/dot-clojure {:git/tag "v1.2.0" :git/sha "2d77f64"}
                   nrepl/nrepl {:mvn/version "RELEASE"}
                   cider/cider-nrepl {:mvn/version "RELEASE"}
                   com.bhauman/rebel-readline {:mvn/version "RELEASE"}
                   djblue/portal {:mvn/version "RELEASE"}}
       :main-opts ["-m" "org.corfield.dev.repl"]}

      ;; add common test runners
      :test {:extra-paths ["test" "src/test/clojure"]
             :extra-deps {org.clojure/test.check {:mvn/version "RELEASE"}
                        io.github.cognitect-labs/test-runner
                        {:git/tag "v0.5.1" :git/sha "dfb30dd"}}}

      ;; add clojure versions
      :1.12 {:override-deps {org.clojure/clojure {:mvn/version "1.12.0"}}}
      :1.11 {:override-deps {org.clojure/clojure {:mvn/version "1.11.4"}}}
      :1.10 {:override-deps {org.clojure/clojure {:mvn/version "1.10.3"}}}

      ;; development tools
      :outdated {:extra-deps {com.github.liquidz/antq {:mvn/version "RELEASE"}}
                :main-opts ["-m" "antq.core"]}

      :portal {:extra-deps {djblue/portal {:mvn/version "RELEASE"}}}

      :nrepl {:extra-deps {nrepl/nrepl {:mvn/version "RELEASE"}}
              :main-opts ["-m" "nrepl.cmdline"]}

      :cider-nrepl {:extra-deps {cider/cider-nrepl {:mvn/version "RELEASE"}}
                   :main-opts ["-m" "nrepl.cmdline" "--middleware" "[cider.nrepl/cider-middleware]"]}

      :rebel {:extra-deps {com.bhauman/rebel-readline {:mvn/version "RELEASE"}}
              :main-opts ["-m" "rebel-readline.main"]}

      ;; formatting/linting
      :fmt {:extra-deps {cljfmt/cljfmt {:mvn/version "RELEASE"}}
            :main-opts ["-m" "cljfmt.main" "fix"]}

      :lint {:extra-deps {clj-kondo/clj-kondo {:mvn/version "RELEASE"}}
             :main-opts ["-m" "clj-kondo.main" "--lint" "src" "test"]}}}
  '';
}