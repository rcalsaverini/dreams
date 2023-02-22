# Code samples

## Tuples

```haskell
    -- Define a tuple datatype, with a type constructor (_, _) and a value constructor (_, _)
    let (_, _): forall a b . (a: Type, b: Type) => a -> b -> Type
    let (_, _): forall a b x y. (a: Type, b: Type, x: a, y: b) => x -> y -> (a, b)

    -- define a function to act on tuples
    let swap: forall a b . (a: Type, b: Type) => (a, b) -> (b, a) where
        swap (x, y) = (y, x)
```

## Lists

```haskell
    -- Define a list datatype, with a type constructor [_] and two value constructor [] and (_ :: _)
    let [_]: forall a . (a: Type) => a -> Type
    let []: forall a . (a: Type) => Type
    let (_ :: _): forall a x xs . (a: Type, x: a, xs: [a]) => x -> xs -> [a]

    -- define the length function
    let length: forall a . (a: Type) => [a] -> Int where
        length [] = 0
        length (_ :: xs) = 1 + length xs
```

## Fixed length vectors

```haskell
    -- define a vector datatype, with a type constructor Vector _ _, and two value constructor nil and (_ :: _)
    let vector _ _: forall a . (a: Type) => Int -> a -> Type
    let nil: forall a . (a: Type) => vector 0 a
    let (_ :: _): forall a n x xs . (a: Type, n: Int, x: a, xs: vector n a) => x -> xs -> vector (n + 1) a

    -- define a function head
    let head : forall a n . (a: Type, n: Int) => vector (n + 1) a -> a where
        head (x :: _) = x

    let length: forall a n . (a: Type, n: Int) => vector n a -> Int where
        head _ = n
```

## Functors, Applicatives and Monads

```haskell

let mapper: forall a b f . (a: Type, b: Type, f: Type -> Type) => a -> b -> f -> Synonym
let mapper: forall a b f . (a: Type, b: Type, f: Type -> Type) => (a -> b) -> f a -> f b -> mapper a b f

let functor: forall f . (f: Type -> Type) => f -> Constraint
let functorInstance: forall f map . (f: Type -> Type, map: forall a b . (a: Type, b: Type) => mapper a b f) => mapper -> functor f

let implicit listFunctor: functor [] where
    let map: forall a b . (a: Type, b: Type) => mapper a b [] where
        map f [] = []
        map f (x :: xs) = (f x) :: (map f xs)
    
    listFunctor = functorInstance map

let map: forall m f u v: (u: Type, v: Type, f: Type -> Type, m: forall a b . (a: Type, b: Type) => mapper a b f, functor f via functorInstance m) => (u -> v) -> f u -> f v
    map g xs = m g xs

```

Alternate syntax for shorter lines:

```haskell

    let functor: forall f . f: Type -> Type => f -> Constraint where
        functor f = (map: forall a b . (a -> b) -> f a -> f b) -> Constraint

    -- note that: `functor m f` implies `f: Type -> Type` and `m: forall a b . (a -> b) -> f a -> f b`
    let map: forall a b m f . (a: Type, b: Type, functor m f) => (a -> b) -> f a -> f b
        map = m

```

## Probability

```haskell
    let Sampleable: forall a . (a: Type) => a -> Constraint
    let Sampleable: forall domain seed sampler . (domain: Type, seed: Type, sampler: seed -> (seed, domain)) => domain -> seed -> sampler -> Sampleable domain

    let sample: forall a . exists seed sampler . Sampleable a seed sampler => seed -> (seed, a)
        sample = sampler

````
