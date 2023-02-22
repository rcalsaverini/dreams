entity Customer where
    name :: String
    age :: Int

entity Customer where
    names :: String
    price :: Money

event Order where
  Key Order = customer :: Customer
  products :: Map[Product, Quantity]
  
state LifeTimeValue where
  Key LifeTimeValue = customer :: Customer
  value :: Money

  update :: Order -> LifeTimeValue -> LifeTimeValue
  update order ltv = ltv { value = value ltv + orderValue order }
    where orderValue order = sum [ price product * quantity | (product, quantity) <- products order ]

  init :: LifeTimeValue
  init = LifeTimeValue { value = 0 }
