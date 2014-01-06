;; monaxhyd -- Monads for Hy
;; Copyright (c) 2014 Gergely Nagy <algernon@madhouse-project.org>
;; Heavily based on clojure.algo.monads by Konrad Hinsen and others.
;;
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 which can be found in the file
;; epl-v10.html at the root of this distribution. By using this
;; software in any fashion, you are agreeing to be bound by the terms
;; of this license. You must not remove this notice, or any other,
;; from this software.

(import [functools [reduce]])

(defn reverse [l]
  (let [[nl (list l)]]
    (.reverse nl)
    nl))

(defn ensure-items [n steps]
  (let [[res (list steps)]]
    (while (< (len res) n)
      (setv res (+ res [nil])))
    res))

(defn each3-steps [steps]
  (let [[n (len steps)]]
    (map (fn [&rest i] i)
         (ensure-items n steps)
         (ensure-items n (rest steps))
         (ensure-items n (rest (rest steps))))))

(defn add-monad-step [mexpr steps]
  (let [[ff (first steps)]
        [bform (first ff)]
        [expr (second ff)]]
    `(m-bind ~expr (fn [~bform] ~mexpr))))

(defn monad-expr [steps expr]
  (let [[rsteps (-> steps reverse each3-steps)]]
    (reduce add-monad-step
            rsteps
            `(m-result ~expr))))
