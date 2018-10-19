;; monaxhyd -- Monads for Hy
;; Copyright (c) 2014, 2015 Gergely Nagy <algernon@madhouse-project.org>
;; Heavily based on clojure.algo.monads by Konrad Hinsen and others.
;;
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 which can be found in the file
;; EPL-1.0.txt at the root of this distribution. By using this
;; software in any fashion, you are agreeing to be bound by the terms
;; of this license. You must not remove this notice, or any other,
;; from this software.

(import [functools [reduce]])
(import [itertools [tee zip-longest]])

(require [hy.contrib.walk [let]])


(defn each3-steps [steps]
  (setv [a b c] (tee steps 3))
  (zip-longest a (rest b) (rest (rest c))))

(defn add-monad-step [mexpr steps]
  (let [ff (first steps)
        bform (first ff)
        expr (second ff)]
    `(m-bind ~expr (fn [~bform] ~mexpr))))

(defn monad-expr [steps expr]
  (let [rsteps (-> steps reversed each3-steps)]
    (reduce add-monad-step
            rsteps
            `(m-result ~expr))))
