# API

## Interval
`{Interval}` represents a line segment on the
  the number line.

An (interval)[http://mathworld.wolfram.com/Interval.html]
is a connected portion of the real line.

Also see (A Small Set of Formal Topological Relationships Suitable
  for End User Interaction)[http://www.gdmc.nl/oosterom/atti.pdf]

A couple of definitions:

* The boundary of an `{Interval}` is set of its two endpoints.
* The interior of an `{Interval}` is the set of all points
  in the `{Interval}` less its boundary (endpoints).

### Properties


### Methods

#### constructor()

Create a immutable `{Interval}` object


Create a immutable `{Interval}` object

Accepts the following types of inputs:

* A `{String}` "<number> <sep> <number>" where sep can be any one of
  a comma, semicolon, or a space
* A {Array<Number>} of two numbers
* An `{Object}` with one of these key combinations:
  * obj.from, obj.to
  * obj.start, obj.end
  * obj.a, obj.b
* two `{Numbers}`

#### contains(other)

Checks if this `{Interval}` contains the other.

* **other** `{Interval}` the other interval

Checks if this `{Interval}` contains the other.

#### overlaps(other)

The `{Interval}`s have some points in common, but not all.

* **other** `{Interval}` the other interval

The `{Interval}`s have some points in common, but not all.

#### within(other)

One `{Interval}` is completely within the other
  with no touching endpoints.

* **other** `{Interval}` the other interval

One `{Interval}` is completely within the other
  with no touching endpoints.

#### touches(other)

Checks if this `{Interval}` touches the other.

* **other** `{Interval}` the other interval

Checks if this `{Interval}` touches the other.

Two line segments touch, if:

* one their endpoints touch
* their interiors do not share any common points

#### disjoint(other)

Intersection with other `{Interval}` is empty

* **other** `{Interval}` the other interval

Intersection with other `{Interval}` is empty

#### union(others)

Calculates the union of the given `{Intervals}`

* **others** {Array<Interval>} One or more intervals Returns `{Interval}` or an {Array<Interval>}

Calculates the union of the given `{Intervals}`

A union of intervals can result in an array of unconnected parts.

#### intersection(other)

Calculates the intersection, i.e. the points where they concur.

* **other** `{Interval}` The other interval Returns an `{Interval}` with the intersection or undefined if the two do not intersect.

Calculates the intersection, i.e. the points where they concur.

#### difference()

summary


summary

 A\B={x:x in A and x not in B}.

#### xor(other)

Compute an XOR with the given `{Interval}`

* **other** `{Interval}` The other

Compute an XOR with the given `{Interval}`

The set of elements belonging to one but not both of two given sets.
It is therefore the union of the complement of A with respect to
B and B with respect to  A, and corresponds to the XOR operation in
Boolean logic.

#### equals(other)

Check if both `{Interval}`s are equal

* **other** `{Interval}` the other interval

Check if both `{Interval}`s are equal

#### toString()

Get a `{String}` representation of this `{Interval}`


Get a `{String}` representation of this `{Interval}`


### Events



