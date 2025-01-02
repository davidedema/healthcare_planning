(define (problem hc1)
    (:domain healthcare)
    (:objects
        r1 - shilded_bot
        l1 l2 - normal_location
        l3 - normal_location
        l4 - dangerous_location
        u1 u2 u3 - unit
        b1 b2 b3 - box
        s1 s2 s3 - supply
        c1 - carrier
        sl1 sl2 sl3 - slot
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
        (free r1)
        (empty b1)
        (empty b2)
        (empty b3)
        (has_supply_at s1 l1)
        (has_supply_at s2 l1)
        (has_supply_at s3 l1)

        (has_slot c1 sl1)
        (has_slot c1 sl2)

        (at_location_carrier c1 l2)

        (has r1 c1)

        (empty_slot sl1)
        (empty_slot sl2)
        (empty_slot sl3)
    )
    (:goal
        (and
            (has_unit s1 u1)
        )
    )
    (:metric minimize
        (total-time)
    )
)