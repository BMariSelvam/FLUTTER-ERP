class HttpUrl {
  static String orgID = '1';

  // static const String base = 'http://154.26.130.251:467/';

  static const String base = 'http://154.26.130.251:302/';

  static String login = '${base}api/Login';

  static String getCustomer = '${base}GetAllCustomers?';

  static String getAllCustomerSearch = '${base}GetAllCustomersSearch?';

  static String getReceiptRemove = '${base}Receipt/Remove?';

  static String getSupplier = '${base}GetAllSupplier?';

  static String getTax = '${base}Tax/GetAll?';

  static String getTaxByCode = '${base}Tax/Getbycode?';

  static String getBank = '${base}Bank/GetAll?';

  static String getPaymode = '${base}Paymode/GetAll?';

  static String getOrganization = '${base}Organization/GetAllOrganization';

  static String getProduct = '${base}Product/GetAll?';

  static String getProductCode = '${base}Product/Getbycode?';

  static String getProductWithImage = '${base}Product/GetAllWithImage?';

  static String getBrand = '${base}Brand/GetAll?';

  static String getCategory = '${base}Category/GetAllWithSubcategory?';

  static String getAllCategory = '${base}Category/GetAll?';

  static String getSubCategory = '${base}SubCategory/GetAll?';

  static String getSubCategoryByCategoryCode =
      '${base}SubCategory/GetbyCategoryCode?';

  static String getUom = '${base}UOM/GetAll?';

  static String getSalesOrder = '${base}SalesOrder/GetAllHeader?';

  static String getSalesOrderHeaderSearch =
      '${base}SalesOrder/GetHeaderSearch?';
  static String getInvoiceHeaderSearch = '${base}Invoice/GetHeaderSearch?';

  static String getInvoice = '${base}Invoice/GetAllHeader?';

  static String getProductStock = '${base}Product/GetAllProductStock?';

  static String getBranches = '${base}Branch/GetAllBranches?';

  static String postSalesOrder = '${base}SalesOrder/Create';

  static String postReceipt = '${base}Receipt/Create';

  static String postInvoice = '${base}Invoice/Create';

  static String postAddTax = '${base}Tax/CreateTax';

  static String postAddBank = '${base}Bank/CreateBank';

  static String postAddPaymode = '${base}Paymode/Create';

  static String postAddUom = '${base}UOM/CreateUOM';

  static String getPurchaseOrder = '${base}PurchaseOrder/GetAllHeader?';

  static String getStockInDo = '${base}StockInDO/GetAllHeader?';

  static String getPayment = '${base}Payment/GetAllHeader?';

  static String getSalesReturn = '${base}SalesReturn/GetAllHeader?';

  static String postBrand = '${base}Brand/CreateBrand';

  static String postSubCategory = '${base}SubCategory/CreateSubCategory';

  static String getReceipt = '${base}Receipt/GetAllHeader?';

  static String getReceiptByCode = '${base}Receipt/Getbycode?';

  static String getReceiptHeaderSearch = '${base}Receipt/GetHeaderSearch?';

  static String getTranforPayment = '${base}Receipt/GetTranforPayment?';

  static String postSettlement = '${base}Settlement/Create';

  static String postPurchaseOrder = '${base}PurchaseOrder/Create';

  static String getCurrency = '${base}Currency/GetAll?';

  static String getCurrencyByCode = '${base}Currency/Getbycode?';

  static String postCustomer = '${base}CreateCustomer';

  static String getCountry = '${base}Country/GetAll?';

  static String getCustomerByCode = '${base}GetCustomerbycode?';

  static String getSalesOrderByCode = '${base}SalesOrder/Getbycode?';

  static String getProductByCode = '${base}Product/Getbycode?';

  static String getInvoiceByCode = '${base}Invoice/Getbycode?';

  static String getAllAutocompleteProduct =
      '${base}AutoComplete/GetAllAutocomplete?';
}
