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

(require monaxhyd.core)

(defmonad identity-m
  [[m-result (fn [r] r)]
   [m-bind   (fn [mv f]
               (f mv))]])

(defmonad maybe-m
  [[m-zero   nil]
   [m-result (fn [v] v)]
   [m-bind   (fn [mv f]
               (if (is mv nil)
                 nil
                 (f mv)))]
   [m-plus   (fn [&rest mvs]
               (first (drop-while (fn [x] (is x nil)) mvs)))]])

(defmonad sequence-m
  [[m-result (fn [v] [v])]
   [m-bind   (fn [mv f]
               (flatten (map f mv)))]
   [m-zero   []]
   [m-plus   (fn [&rest mvs] (flatten mvs))]])
