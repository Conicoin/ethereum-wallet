public enum Result<Object> {
    case success(Object)
    case failure(Error)
    
    /// For debug use only
    public var description: String {
        switch self {
        case .success(let object):
            return "success: \(object)"
        case .failure(let error):
            return "failed: \(error)"
        }
    }
}
