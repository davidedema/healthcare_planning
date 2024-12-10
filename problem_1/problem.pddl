(define (problem hc1) (:domain healthcare)
(:objects 
r1 - box_robot
l1 l2 - location
u1 u2 - unit
b1 b2 b3 - box
)

(:init
    (adjacent l1 l2)
    (adjacent l2 l1)
    (is_loading_point l1)
    (belongs u1 l2)
    (belongs u2 l2)
    (at b1 l1)
    (at b2 l1)
    (at b3 l1)
    (atl r1 l1)
    (free r1)
    (empty b1)
    (empty b2)
    (empty b3)
)

(:goal (and
    (has_bandages u1)
    (has_bandages u2)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
