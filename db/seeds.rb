User.create({
    name: "test", email: "test@test.com", 
    password: "test", account_balance: 50
})

Goal.create({
    name: "test goal", goal_amount: 200, current_amount: 0
})

Transaction.create({amount: 50})