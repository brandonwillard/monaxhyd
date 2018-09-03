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
(import [monaxhyd._tools :as t/])

(require [hy.contrib.walk [let]])

(defmacro/g! monad [operations]
  `(do
     (require [hy.contrib.walk [let :as ~g!let]])
     (~g!let [m-bind   'undefined
              m-result 'undefined
              m-zero   'undefined
              m-plus   'undefined]
      (~g!let [~@operations]
               {'m-result  m-result
                'm-bind    m-bind
                'm-zero    m-zero
                'm-plus    m-plus}))))

(defmacro defmonad [name operations]
  `(setv ~name (monad ~operations)))

(defmacro/g! with-monad [monad &rest exprs]
  `(do
     (require [hy.contrib.walk [let :as ~g!let]])
     (~g!let [~g!g      ~monad
              m-bind    (get ~g!g 'm-bind)
              m-result  (get ~g!g 'm-result)
              m-zero    (get ~g!g 'm-zero)
              m-plus    (get ~g!g 'm-plus)]
      ~@exprs)))

(defmacro domonad [name steps expr]
  (let [mexpr (t/.monad-expr steps expr)]
    `(with-monad ~name ~mexpr)))
