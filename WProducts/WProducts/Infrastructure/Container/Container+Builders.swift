
import Foundation

// MARK: - Builders Injection

extension Container {

    func splitBuilder() -> SplitBuilder {
        return SplitDefaultBuilder()
    }
    
    func productListBuilder() -> ProductListBuilder {
        return ProductListDefaultBuilder()
    }

    func productBuilder() -> ProductBuilder {
        return ProductDefaultBuilder()
    }

}
