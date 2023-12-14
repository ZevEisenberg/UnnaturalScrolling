func with<T>(_ t: T, transform: (inout T) throws -> Void) rethrows -> T {
    var t = t
    try transform(&t)
    return t
}
