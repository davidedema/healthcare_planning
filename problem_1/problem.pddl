(define (problem hc1) (:domain healthcare)
(:objects 
r1 - box_robot
r2 - guide_robot
l1 l2 l3 - location
u1 u2 u3 - unit
b1 b2 b3 - box
p1 p2 - person
)

(:init
    (adjacent l1 l2)
    (adjacent l2 l1)
    (adjacent l2 l3)
    (adjacent l3 l2)
    (is_loading_point l1)
    (belongs u1 l3)
    (belongs u2 l3)
    (belongs u3 l2)
    (at b1 l1)
    (at b2 l1)
    (at b3 l1)
    (atl r1 l2)
    (atl r2 l2)
    (inl p1 l2)
    (inl p2 l2)
    (in p1 u3)
    (in p2 u3)
    (free r1)
    (free r2)
    (empty b1)
    (empty b2)
    (empty b3)
)

(:goal (and
    (has_bandages u1)
    (has_bandages u2)
    (in p1 u2)
    (in p2 u1)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
