(define (problem hc1)
    (:domain healthcare)
    (:objects
        r1 - shilded_bot
        r3 - flying_robot
        r2 - guide_robot
        r4 - guide_robot
        l1 l2 l3 l5 l6 l8 - normal_location
        l4 l7 - dangerous_location
        u1 u2 u3 u4 u5 u6 u7 - unit
        b1 b2 b3 b4 b5 - box
        p1 p2 p3 p4 - person
        s1 s2 s3 s4 s5 - supply
        c1 c2 - carrier
        sl1 sl2 sl3 - slot
    )

    (:init
        (adjacent l1 l2)
        (adjacent l2 l1)
        (adjacent l2 l3)
        (adjacent l3 l2)
        (adjacent l3 l4)
        (adjacent l4 l3)
        (adjacent l3 l5)
        (adjacent l5 l3)
        (adjacent l5 l6)
        (adjacent l6 l5)
        (adjacent l2 l7)
        (adjacent l7 l2)
        (adjacent l7 l8)
        (adjacent l8 l7)
        (belongs u1 l3)
        (belongs u2 l4)
        (belongs u3 l2)
        (belongs u4 l6)
        (belongs u5 l6)
        (belongs u6 l8)
        (belongs u7 l7)
        (at b1 l1)
        (at b2 l1)
        (at b3 l1)
        (at b4 l1)
        (at b5 l1)
        (atl r1 l2)
        (atl r2 l2)
        (atl r3 l2)
        (atl r4 l2)
        (inl p1 l2)
        (inl p2 l2)
        (inl p3 l2)
        (inl p4 l2)
        (in p1 u3)
        (in p2 u3)
        (in p3 u3)
        (in p4 u3)
        (free r1)
        (free r2)
        (free r3)
        (free r4)
        (empty b1)
        (empty b2)
        (empty b3)
        (empty b4)
        (empty b5)
        (has_supply_at s1 l1)
        (has_supply_at s2 l1)
        (has_supply_at s3 l1)
        (has_supply_at s4 l1)
        (has_supply_at s5 l1)

        (has_slot c1 sl1)
        (has_slot c1 sl2)
        (has_slot c2 sl3)

        (at_location_carrier c1 l2)
        (at_location_carrier c2 l2)

        (has r3 c2)
        (has r1 c1)

        (empty_slot sl1)
        (empty_slot sl2)
        (empty_slot sl3)
    )

    (:goal
        (and
            (has_unit s1 u1)
            (has_unit s2 u3)
            (has_unit s3 u2)
            (has_unit s4 u6)
            (has_unit s5 u5)
            (in p1 u1)
            (in p2 u5)
            (in p3 u4)
            (in p4 u4)
        )
    )
    (:metric minimize
        (total-time)
    )

)