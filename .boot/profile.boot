;; `boot ancient` to show outdated deps
(set-env! :dependencies '[[boot-deps "0.1.9"]])
(require '[boot-deps :refer [ancient]])

(deftask cider "CIDER profile"
   []
   (require 'boot.repl)
   (swap! @(resolve 'boot.repl/*default-dependencies*)
          concat '[[org.clojure/tools.nrepl "0.2.12"]
                   [cider/cider-nrepl "0.18.0"]
                   [refactor-nrepl "2.4.0"]])
   (swap! @(resolve 'boot.repl/*default-middleware*)
          concat '[cider.nrepl/cider-middleware
                   refactor-nrepl.middleware/wrap-refactor])
   identity)

