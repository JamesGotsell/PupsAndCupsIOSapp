import Foundation

struct MockData {
    // MARK: - Business IDs (stable for consistency)
    static let pupsAndCupsId = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!
    static let sweetTreatsId = UUID(uuidString: "22222222-2222-2222-2222-222222222222")!
    static let pageAndBindId = UUID(uuidString: "33333333-3333-3333-3333-333333333333")!
    static let fitZoneId = UUID(uuidString: "44444444-4444-4444-4444-444444444444")!
    static let glowSpaId = UUID(uuidString: "55555555-5555-5555-5555-555555555555")!
    static let urbanBitesId = UUID(uuidString: "66666666-6666-6666-6666-666666666666")!
    static let techHubId = UUID(uuidString: "77777777-7777-7777-7777-777777777777")!
    static let greenLeafId = UUID(uuidString: "88888888-8888-8888-8888-888888888888")!

    // MARK: - Businesses
    static let businesses: [Business] = [
        Business(
            id: pupsAndCupsId,
            name: "Pups & Cups",
            description: "Your favorite dog-friendly coffee shop! Enjoy premium coffee and pastries while puppies play around you. We partner with local shelters to bring adoptable pups to our locations.",
            category: .coffee,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Downtown", address: "123 Main Street", hours: "Mon-Fri 7am-6pm, Sat-Sun 8am-5pm", latitude: 40.7128, longitude: -74.0060),
                Location(id: UUID(), name: "Westside", address: "456 West Ave", hours: "Mon-Fri 6am-7pm, Sat-Sun 7am-6pm", latitude: 40.7580, longitude: -73.9855),
                Location(id: UUID(), name: "Eastside", address: "789 East Blvd", hours: "Mon-Fri 7am-5pm", latitude: 40.7614, longitude: -73.9776)
            ],
            contactEmail: "hello@pupsandcups.com",
            website: "https://pupsandcups.com"
        ),
        Business(
            id: sweetTreatsId,
            name: "Sweet Treats Bakery",
            description: "Artisan baked goods made fresh daily. From buttery croissants to custom celebration cakes, we've got your sweet cravings covered. All recipes are family traditions passed down through generations.",
            category: .restaurant,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Main Store", address: "200 Baker Street", hours: "Tue-Sun 7am-4pm", latitude: 40.7505, longitude: -73.9934),
                Location(id: UUID(), name: "Farmers Market", address: "Union Square Greenmarket", hours: "Sat 8am-2pm", latitude: 40.7359, longitude: -73.9911)
            ],
            contactEmail: "orders@sweettreats.com",
            website: "https://sweettreats.com"
        ),
        Business(
            id: pageAndBindId,
            name: "Page & Bind Books",
            description: "Independent bookstore with a cozy reading nook. New releases, rare finds, and weekly local author events. We believe every book deserves a loving home.",
            category: .retail,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Bookstore", address: "555 Library Lane", hours: "Mon-Sat 10am-9pm, Sun 11am-6pm", latitude: 40.7282, longitude: -73.7949),
                Location(id: UUID(), name: "Airport Kiosk", address: "JFK Terminal 4", hours: "Daily 6am-10pm", latitude: 40.6413, longitude: -73.7781)
            ],
            contactEmail: "info@pageandbind.com",
            website: "https://pageandbind.com"
        ),
        Business(
            id: fitZoneId,
            name: "FitZone Gym",
            description: "24/7 fitness center with state-of-the-art equipment, certified personal trainers, and over 50 weekly group classes. Your fitness journey starts here.",
            category: .fitness,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Midtown", address: "300 Fitness Ave", hours: "Open 24/7", latitude: 40.7549, longitude: -73.9840),
                Location(id: UUID(), name: "Brooklyn Heights", address: "88 Gym Street", hours: "Open 24/7", latitude: 40.6960, longitude: -73.9936)
            ],
            contactEmail: "members@fitzone.com",
            website: "https://fitzone.com"
        ),
        Business(
            id: glowSpaId,
            name: "Glow Spa & Wellness",
            description: "Luxurious day spa offering massages, facials, and holistic wellness treatments. Escape the city stress and find your inner peace with our expert therapists.",
            category: .beauty,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "SoHo", address: "42 Relaxation Way", hours: "Mon-Sun 9am-9pm", latitude: 40.7233, longitude: -74.0030),
                Location(id: UUID(), name: "Upper East Side", address: "880 Madison Ave", hours: "Mon-Sat 10am-8pm", latitude: 40.7736, longitude: -73.9654)
            ],
            contactEmail: "bookings@glowspa.com",
            website: "https://glowspa.com"
        ),
        Business(
            id: urbanBitesId,
            name: "Urban Bites Food Hall",
            description: "Modern food hall featuring 12 diverse culinary concepts under one roof. From sushi to tacos, ramen to BBQ - satisfy every craving in one stop.",
            category: .restaurant,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Chelsea Market", address: "75 9th Avenue", hours: "Mon-Sun 11am-10pm", latitude: 40.7424, longitude: -74.0061)
            ],
            contactEmail: "hello@urbanbites.com",
            website: "https://urbanbites.com"
        ),
        Business(
            id: techHubId,
            name: "TechHub Electronics",
            description: "Your neighborhood electronics store with expert advice. We sell, repair, and recycle gadgets. Trade in your old devices for store credit!",
            category: .retail,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Flagship Store", address: "100 Tech Plaza", hours: "Mon-Sat 10am-8pm, Sun 11am-6pm", latitude: 40.7589, longitude: -73.9851),
                Location(id: UUID(), name: "Repair Center", address: "102 Tech Plaza", hours: "Mon-Fri 9am-6pm", latitude: 40.7590, longitude: -73.9850)
            ],
            contactEmail: "support@techhub.com",
            website: "https://techhub.com"
        ),
        Business(
            id: greenLeafId,
            name: "Green Leaf Grocery",
            description: "Organic and locally-sourced grocery store. Fresh produce, sustainable products, and zero-waste options. Good for you, good for the planet.",
            category: .other,
            logoURL: nil,
            locations: [
                Location(id: UUID(), name: "Park Slope", address: "234 Organic Lane", hours: "Daily 7am-10pm", latitude: 40.6710, longitude: -73.9814),
                Location(id: UUID(), name: "Williamsburg", address: "567 Green Street", hours: "Daily 8am-9pm", latitude: 40.7081, longitude: -73.9571),
                Location(id: UUID(), name: "Astoria", address: "890 Fresh Ave", hours: "Daily 7am-9pm", latitude: 40.7644, longitude: -73.9235)
            ],
            contactEmail: "info@greenleafgrocery.com",
            website: "https://greenleafgrocery.com"
        )
    ]

    // MARK: - Customer
    static let customer = Customer(
        id: UUID(uuidString: "A1B2C3D4-E5F6-7890-ABCD-EF1234567890")!,
        name: "Jamie Brewster",
        email: "jamie@example.com",
        memberSince: Calendar.current.date(byAdding: .month, value: -14, to: Date())!
    )

    // MARK: - Memberships (user is a member of 6 businesses)
    static var memberships: [Membership] {
        [
            Membership(
                id: UUID(),
                businessId: pupsAndCupsId,
                business: businesses[0],
                pointsBalance: 1250,
                lifetimePoints: 4850,
                joinedDate: Calendar.current.date(byAdding: .month, value: -14, to: Date())!
            ),
            Membership(
                id: UUID(),
                businessId: sweetTreatsId,
                business: businesses[1],
                pointsBalance: 450,
                lifetimePoints: 1290,
                joinedDate: Calendar.current.date(byAdding: .month, value: -6, to: Date())!
            ),
            Membership(
                id: UUID(),
                businessId: pageAndBindId,
                business: businesses[2],
                pointsBalance: 375,
                lifetimePoints: 725,
                joinedDate: Calendar.current.date(byAdding: .month, value: -4, to: Date())!
            ),
            Membership(
                id: UUID(),
                businessId: fitZoneId,
                business: businesses[3],
                pointsBalance: 890,
                lifetimePoints: 2340,
                joinedDate: Calendar.current.date(byAdding: .month, value: -8, to: Date())!
            ),
            Membership(
                id: UUID(),
                businessId: glowSpaId,
                business: businesses[4],
                pointsBalance: 1500,
                lifetimePoints: 3200,
                joinedDate: Calendar.current.date(byAdding: .month, value: -5, to: Date())!
            ),
            Membership(
                id: UUID(),
                businessId: greenLeafId,
                business: businesses[7],
                pointsBalance: 225,
                lifetimePoints: 580,
                joinedDate: Calendar.current.date(byAdding: .month, value: -2, to: Date())!
            )
        ]
    }

    // MARK: - Transactions
    static var transactions: [Transaction] {
        [
            // Today & Yesterday - Pups & Cups
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!,
                description: "Caramel Pup Latte",
                pointsEarned: 50,
                locationName: "Downtown",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .hour, value: -5, to: Date())!,
                description: "Blueberry Muffin",
                pointsEarned: 35,
                locationName: "Downtown",
                type: .earn
            ),
            // Yesterday - Multiple businesses
            Transaction(
                id: UUID(),
                businessId: fitZoneId,
                businessName: "FitZone Gym",
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                description: "Spin Class",
                pointsEarned: 75,
                locationName: "Midtown",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: greenLeafId,
                businessName: "Green Leaf Grocery",
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                description: "Weekly Groceries",
                pointsEarned: 125,
                locationName: "Park Slope",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                description: "Puppy Play Session",
                pointsEarned: 100,
                locationName: "Westside",
                type: .earn
            ),
            // 2 days ago
            Transaction(
                id: UUID(),
                businessId: sweetTreatsId,
                businessName: "Sweet Treats Bakery",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                description: "Chocolate Croissant",
                pointsEarned: 35,
                locationName: "Main Store",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                description: "Free Biscotti Redeemed",
                pointsEarned: -200,
                locationName: "Downtown",
                type: .redeem
            ),
            Transaction(
                id: UUID(),
                businessId: glowSpaId,
                businessName: "Glow Spa & Wellness",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                description: "Swedish Massage 60min",
                pointsEarned: 350,
                locationName: "SoHo",
                type: .earn
            ),
            // 3 days ago
            Transaction(
                id: UUID(),
                businessId: sweetTreatsId,
                businessName: "Sweet Treats Bakery",
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                description: "Birthday Cake Order",
                pointsEarned: 250,
                locationName: "Main Store",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pageAndBindId,
                businessName: "Page & Bind Books",
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                description: "Novel Purchase",
                pointsEarned: 75,
                locationName: "Bookstore",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: fitZoneId,
                businessName: "FitZone Gym",
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                description: "Personal Training",
                pointsEarned: 150,
                locationName: "Midtown",
                type: .earn
            ),
            // 4 days ago
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                description: "Tail Wagger Mocha",
                pointsEarned: 55,
                locationName: "Downtown",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: greenLeafId,
                businessName: "Green Leaf Grocery",
                date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                description: "Organic Produce",
                pointsEarned: 85,
                locationName: "Williamsburg",
                type: .earn
            ),
            // 5 days ago
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                description: "Puppy Cuddle Hour",
                pointsEarned: 75,
                locationName: "Westside",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: fitZoneId,
                businessName: "FitZone Gym",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                description: "Yoga Class",
                pointsEarned: 50,
                locationName: "Brooklyn Heights",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: glowSpaId,
                businessName: "Glow Spa & Wellness",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                description: "Facial Treatment",
                pointsEarned: 275,
                locationName: "Upper East Side",
                type: .earn
            ),
            // 6 days ago
            Transaction(
                id: UUID(),
                businessId: sweetTreatsId,
                businessName: "Sweet Treats Bakery",
                date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
                description: "Almond Croissant",
                pointsEarned: 40,
                locationName: "Farmers Market",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pageAndBindId,
                businessName: "Page & Bind Books",
                date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
                description: "Children's Book Set",
                pointsEarned: 120,
                locationName: "Bookstore",
                type: .earn
            ),
            // 7 days ago
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                description: "Espresso Fetch",
                pointsEarned: 40,
                locationName: "Eastside",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: fitZoneId,
                businessName: "FitZone Gym",
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                description: "Free Guest Pass Redeemed",
                pointsEarned: -200,
                locationName: "Midtown",
                type: .redeem
            ),
            // 8-10 days ago
            Transaction(
                id: UUID(),
                businessId: greenLeafId,
                businessName: "Green Leaf Grocery",
                date: Calendar.current.date(byAdding: .day, value: -8, to: Date())!,
                description: "Bulk Items Purchase",
                pointsEarned: 95,
                locationName: "Astoria",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: glowSpaId,
                businessName: "Glow Spa & Wellness",
                date: Calendar.current.date(byAdding: .day, value: -9, to: Date())!,
                description: "Manicure & Pedicure",
                pointsEarned: 125,
                locationName: "SoHo",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                description: "Woof Blend Coffee Beans",
                pointsEarned: 85,
                locationName: "Downtown",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: sweetTreatsId,
                businessName: "Sweet Treats Bakery",
                date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                description: "Free Cookie Redeemed",
                pointsEarned: -100,
                locationName: "Main Store",
                type: .redeem
            ),
            // 11-14 days ago
            Transaction(
                id: UUID(),
                businessId: pageAndBindId,
                businessName: "Page & Bind Books",
                date: Calendar.current.date(byAdding: .day, value: -11, to: Date())!,
                description: "Cookbook Set",
                pointsEarned: 100,
                locationName: "Bookstore",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: fitZoneId,
                businessName: "FitZone Gym",
                date: Calendar.current.date(byAdding: .day, value: -12, to: Date())!,
                description: "HIIT Class",
                pointsEarned: 75,
                locationName: "Midtown",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -13, to: Date())!,
                description: "Paw-ccino",
                pointsEarned: 60,
                locationName: "Downtown",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: glowSpaId,
                businessName: "Glow Spa & Wellness",
                date: Calendar.current.date(byAdding: .day, value: -14, to: Date())!,
                description: "Deep Tissue Massage",
                pointsEarned: 400,
                locationName: "SoHo",
                type: .earn
            ),
            // 2-3 weeks ago
            Transaction(
                id: UUID(),
                businessId: greenLeafId,
                businessName: "Green Leaf Grocery",
                date: Calendar.current.date(byAdding: .day, value: -16, to: Date())!,
                description: "Weekly Groceries",
                pointsEarned: 110,
                locationName: "Park Slope",
                type: .earn
            ),
            Transaction(
                id: UUID(),
                businessId: pageAndBindId,
                businessName: "Page & Bind Books",
                date: Calendar.current.date(byAdding: .day, value: -18, to: Date())!,
                description: "Bookmark Redeemed",
                pointsEarned: -50,
                locationName: "Bookstore",
                type: .redeem
            ),
            Transaction(
                id: UUID(),
                businessId: pupsAndCupsId,
                businessName: "Pups & Cups",
                date: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
                description: "Dog Bandana Redeemed",
                pointsEarned: -500,
                locationName: "Westside",
                type: .redeem
            ),
            Transaction(
                id: UUID(),
                businessId: fitZoneId,
                businessName: "FitZone Gym",
                date: Calendar.current.date(byAdding: .day, value: -21, to: Date())!,
                description: "Boxing Class",
                pointsEarned: 100,
                locationName: "Brooklyn Heights",
                type: .earn
            )
        ]
    }

    // MARK: - Rewards (per business)
    static let pupsAndCupsRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Free Small Coffee",
            description: "Any small hot or iced coffee on us!",
            pointsCost: 200,
            imageName: "cup.and.saucer.fill",
            category: "Drinks",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Puppy Play Session",
            description: "30 minutes of puppy playtime.",
            pointsCost: 350,
            imageName: "pawprint.fill",
            category: "Experiences",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Free Pastry",
            description: "Choose any pastry from the display case.",
            pointsCost: 250,
            imageName: "birthday.cake.fill",
            category: "Food",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Dog Bandana",
            description: "A stylish Pups & Cups bandana for your pup.",
            pointsCost: 500,
            imageName: "tshirt.fill",
            category: "Merch",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Large Specialty Drink",
            description: "Any large specialty drink, hot or iced.",
            pointsCost: 400,
            imageName: "mug.fill",
            category: "Drinks",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Private Puppy Party",
            description: "1-hour private room with puppies for up to 4 guests.",
            pointsCost: 2000,
            imageName: "party.popper.fill",
            category: "Experiences",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Coffee Bag (12oz)",
            description: "Take home our signature Woof Blend beans.",
            pointsCost: 600,
            imageName: "bag.fill",
            category: "Products",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pupsAndCupsId,
            name: "Branded Tumbler",
            description: "Insulated 16oz tumbler with our logo.",
            pointsCost: 800,
            imageName: "cup.and.saucer.fill",
            category: "Merch",
            isAvailable: true
        )
    ]

    static let sweetTreatsRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: sweetTreatsId,
            name: "Free Cookie",
            description: "Any cookie of your choice.",
            pointsCost: 100,
            imageName: "circle.fill",
            category: "Treats",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: sweetTreatsId,
            name: "Free Pastry",
            description: "Choose any pastry from the case.",
            pointsCost: 200,
            imageName: "birthday.cake.fill",
            category: "Treats",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: sweetTreatsId,
            name: "$5 Off Cake Order",
            description: "Discount on any custom cake order.",
            pointsCost: 400,
            imageName: "gift.fill",
            category: "Discounts",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: sweetTreatsId,
            name: "Dozen Macarons",
            description: "Assorted flavors of our signature macarons.",
            pointsCost: 500,
            imageName: "circle.grid.3x3.fill",
            category: "Treats",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: sweetTreatsId,
            name: "Baking Class Pass",
            description: "Join our Saturday morning baking workshop.",
            pointsCost: 800,
            imageName: "person.3.fill",
            category: "Experiences",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: sweetTreatsId,
            name: "Gift Box",
            description: "Curated selection of our best sellers.",
            pointsCost: 600,
            imageName: "shippingbox.fill",
            category: "Gifts",
            isAvailable: true
        )
    ]

    static let pageAndBindRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: pageAndBindId,
            name: "Free Bookmark",
            description: "Artisan handmade bookmark.",
            pointsCost: 50,
            imageName: "bookmark.fill",
            category: "Accessories",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pageAndBindId,
            name: "10% Off Purchase",
            description: "10% off your next book purchase.",
            pointsCost: 150,
            imageName: "percent",
            category: "Discounts",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pageAndBindId,
            name: "Author Event Priority",
            description: "Reserved seating at next author event.",
            pointsCost: 300,
            imageName: "person.fill",
            category: "Experiences",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pageAndBindId,
            name: "Free Paperback",
            description: "Any paperback under $20.",
            pointsCost: 400,
            imageName: "book.fill",
            category: "Books",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pageAndBindId,
            name: "Book Club Membership",
            description: "3-month book club membership with discounts.",
            pointsCost: 600,
            imageName: "person.2.fill",
            category: "Memberships",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: pageAndBindId,
            name: "Tote Bag",
            description: "Canvas tote with literary quote.",
            pointsCost: 250,
            imageName: "bag.fill",
            category: "Merch",
            isAvailable: true
        )
    ]

    static let fitZoneRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Free Day Pass",
            description: "One free guest day pass.",
            pointsCost: 200,
            imageName: "ticket.fill",
            category: "Passes",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Personal Training",
            description: "30-minute 1-on-1 training session.",
            pointsCost: 500,
            imageName: "figure.strengthtraining.traditional",
            category: "Training",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Water Bottle",
            description: "FitZone branded water bottle.",
            pointsCost: 300,
            imageName: "waterbottle.fill",
            category: "Merch",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Protein Shake",
            description: "Any smoothie from our juice bar.",
            pointsCost: 150,
            imageName: "cup.and.saucer.fill",
            category: "Nutrition",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Gym Towel",
            description: "Premium microfiber gym towel.",
            pointsCost: 350,
            imageName: "rectangle.fill",
            category: "Merch",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Group Class Pack",
            description: "5 group fitness class credits.",
            pointsCost: 400,
            imageName: "person.3.fill",
            category: "Classes",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: fitZoneId,
            name: "Nutrition Consult",
            description: "1-hour session with our nutritionist.",
            pointsCost: 750,
            imageName: "heart.fill",
            category: "Wellness",
            isAvailable: true
        )
    ]

    static let glowSpaRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "Express Facial",
            description: "30-minute express facial treatment.",
            pointsCost: 500,
            imageName: "sparkles",
            category: "Facials",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "$20 Off Service",
            description: "$20 off any service over $100.",
            pointsCost: 300,
            imageName: "dollarsign.circle.fill",
            category: "Discounts",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "Aromatherapy Add-On",
            description: "Free aromatherapy upgrade.",
            pointsCost: 150,
            imageName: "leaf.fill",
            category: "Add-Ons",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "Product Sample Set",
            description: "Deluxe samples of our skincare line.",
            pointsCost: 200,
            imageName: "gift.fill",
            category: "Products",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "Massage Upgrade",
            description: "Upgrade to hot stone massage free.",
            pointsCost: 400,
            imageName: "flame.fill",
            category: "Add-Ons",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "Spa Day Package",
            description: "Massage + Facial + Mani combo.",
            pointsCost: 2500,
            imageName: "star.fill",
            category: "Packages",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: glowSpaId,
            name: "Robe & Slippers",
            description: "Take home luxury spa robe set.",
            pointsCost: 1500,
            imageName: "tshirt.fill",
            category: "Products",
            isAvailable: true
        )
    ]

    static let urbanBitesRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: urbanBitesId,
            name: "Free Appetizer",
            description: "Any appetizer from any vendor.",
            pointsCost: 200,
            imageName: "fork.knife",
            category: "Food",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: urbanBitesId,
            name: "Free Drink",
            description: "Any non-alcoholic beverage.",
            pointsCost: 100,
            imageName: "cup.and.saucer.fill",
            category: "Drinks",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: urbanBitesId,
            name: "$10 Off",
            description: "$10 off any order over $30.",
            pointsCost: 300,
            imageName: "dollarsign.circle.fill",
            category: "Discounts",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: urbanBitesId,
            name: "Chef's Tasting",
            description: "5-course tasting across vendors.",
            pointsCost: 800,
            imageName: "star.fill",
            category: "Experiences",
            isAvailable: true
        )
    ]

    static let techHubRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: techHubId,
            name: "Screen Protector",
            description: "Free screen protector installation.",
            pointsCost: 100,
            imageName: "iphone",
            category: "Accessories",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: techHubId,
            name: "Phone Case",
            description: "Any case under $30.",
            pointsCost: 250,
            imageName: "iphone.gen3",
            category: "Accessories",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: techHubId,
            name: "10% Off Repair",
            description: "10% off any repair service.",
            pointsCost: 200,
            imageName: "wrench.fill",
            category: "Services",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: techHubId,
            name: "Charging Cable",
            description: "Premium braided charging cable.",
            pointsCost: 150,
            imageName: "cable.connector",
            category: "Accessories",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: techHubId,
            name: "Tech Support",
            description: "30-min tech support session.",
            pointsCost: 300,
            imageName: "questionmark.circle.fill",
            category: "Services",
            isAvailable: true
        )
    ]

    static let greenLeafRewards: [Reward] = [
        Reward(
            id: UUID(),
            businessId: greenLeafId,
            name: "Reusable Bag",
            description: "Branded canvas shopping bag.",
            pointsCost: 100,
            imageName: "bag.fill",
            category: "Sustainability",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: greenLeafId,
            name: "Free Smoothie",
            description: "Any fresh-made smoothie.",
            pointsCost: 150,
            imageName: "cup.and.saucer.fill",
            category: "Drinks",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: greenLeafId,
            name: "10% Off Produce",
            description: "10% off fresh produce.",
            pointsCost: 200,
            imageName: "leaf.fill",
            category: "Discounts",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: greenLeafId,
            name: "CSA Box Discount",
            description: "$15 off weekly CSA subscription.",
            pointsCost: 400,
            imageName: "shippingbox.fill",
            category: "Subscriptions",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: greenLeafId,
            name: "Cooking Class",
            description: "Farm-to-table cooking workshop.",
            pointsCost: 600,
            imageName: "flame.fill",
            category: "Experiences",
            isAvailable: true
        ),
        Reward(
            id: UUID(),
            businessId: greenLeafId,
            name: "Herb Garden Kit",
            description: "Indoor herb growing kit.",
            pointsCost: 350,
            imageName: "leaf.arrow.triangle.circlepath",
            category: "Products",
            isAvailable: true
        )
    ]

    static func rewards(for businessId: UUID) -> [Reward] {
        switch businessId {
        case pupsAndCupsId:
            return pupsAndCupsRewards
        case sweetTreatsId:
            return sweetTreatsRewards
        case pageAndBindId:
            return pageAndBindRewards
        case fitZoneId:
            return fitZoneRewards
        case glowSpaId:
            return glowSpaRewards
        case urbanBitesId:
            return urbanBitesRewards
        case techHubId:
            return techHubRewards
        case greenLeafId:
            return greenLeafRewards
        default:
            return []
        }
    }
}
