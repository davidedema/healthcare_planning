(define (problem hc1)
    (:domain healthcare)
    (:objects
        r1 r3 - box_robot
        r2 - guide_robot
        l1 l2 l3 l4 - location
        u1 u2 u3 - unit
        b1 b2 b3 - box
        p1 p2 - person
        s1 s2 s3 - supply
    )

    (:init
        (adjacent l1 l2)
        (adjacent l2 l1)
        (adjacent l2 l3)
        (adjacent l3 l2)
        (adjacent l3 l4)
        (adjacent l4 l3)
        (belongs u1 l3)
        (belongs u2 l4)
        (belongs u3 l2)
        (at b1 l1)
        (at b2 l1)
        (at b3 l1)
        (atl r1 l2)
        (atl r2 l2)
        (atl r3 l2)
        (inl p1 l2)
        (inl p2 l2)
        (in p1 u3)
        (in p2 u3)
        (free r1)
        (free r2)
        (free r3)
        (empty b1)
        (empty b2)
        (empty b3)
        (has_supply_at s1 l1)
        (has_supply_at s2 l1)
        (has_supply_at s3 l1)
    )

    (:goal
        (and
            (has_unit s1 u1)
            (in p1 u1)
        )
    )
)