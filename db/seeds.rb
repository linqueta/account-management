linqueta = User.create!(email: 'linqueta@gmail.com', password: '123456')
dad = User.create!(email: 'father@gmail.com', password: 'abcdef')

linqueta.account.events.create!(amount: 100)

Transfer.create!(source_account: linqueta.account, destination_account: dad.account, amount: 15)