const Bill = require('./con/bill');
const Category = require('./con/category');
const Company = require('./con/company');
const Device = require('./con/device');
const DrawerHeader = require('./con/drawer_header');
const Employee = require('./con/employee');
const Outlet = require('./con/outlet');
const PaymentMethod = require('./con/payment_method');
const Printer = require('./con/printer');
const Product = require('./con/product');
const ProductMenu = require('./con/product_menu');
const Properties = require('./con/properties');
const Register = require('./con/register');
const User = require('./con/user');
const routerApi = require('express').Router();

routerApi.get('/get-user-data-by-id', User.getUserDataById);
routerApi.get('/get-user', User.getUser);


// company
routerApi.get('/list-company', Company.getListCompany);
routerApi.post('/company-create', Company.create);
routerApi.get('/company-single', Company.companySingle);

// outlet
routerApi.get('/list-outlet', Outlet.getListOutlet);
routerApi.post('/outlet-create', Outlet.createOutlet);
routerApi.delete('/outlet-delete', Outlet.deleteOutlet);
routerApi.put('/outlet-update', Outlet.updateOutlet);
routerApi.get('/outlet-get-by-company', Outlet.getOutletByCompany);
routerApi.get('/outlet-company-list', Outlet.getListOutletCompany);
routerApi.get('/outlet-by-company-id', Outlet.outletByCompanyId);
routerApi.get('/outlet-single', Outlet.outletSingle);

// category
routerApi.get('/list-category', Category.getListCategory);
routerApi.post('/create-category', Category.createCategory);
routerApi.delete('/category-delete', Category.deleteCategory);
routerApi.put('/category-update', Category.updateCategory);
routerApi.get('/category-get-by-company', Category.getAllCategoryByCompany);
routerApi.get('/category-by-company-id', Category.categoryByCompanyId);


// product
routerApi.get('/product-list', Product.getListProduct);
routerApi.post('/product-create', Product.createProduct);
routerApi.delete('/product-delete', Product.deleteProduct);
routerApi.put('/product-update', Product.updateProduct);
routerApi.get('/product-get-by-category', Product.getProductByCategory);
routerApi.get('/product-search', Product.search);
routerApi.get('/product-create-select', Product.productCreateSelect)
routerApi.get('/product-by-user-id', Product.productbyUserId);
routerApi.get('/list-product', Product.getListProduct);

// payment method
routerApi.get('/payment-method-list', PaymentMethod.getListPaymentMethod);
routerApi.post('/payment-method-create', PaymentMethod.createPaymentMethod);

// bill
routerApi.post('/bill-create', Bill.payment);

// printer
routerApi.get('/printer-bluetooth', Printer.bluetooth);

// device
routerApi.get('/device-list', Device.getDeviceList);
routerApi.post('/device-create', Device.createDevice);
routerApi.delete('/device-delete', Device.deleteDevice);
routerApi.get('/device-by-user', Device.deviceByUser);

// product-menu
routerApi.get('/product-menu/get-property-by-company', ProductMenu.getPropertyByCompany);


// properties
routerApi.get('/properties-company-outlet', Properties.selectCompanyOutlet);
routerApi.get('/properties-company-outlet-category', Properties.getCategoryOutletCompany);
routerApi.get('/properties-category-with-outlet-or-null', Properties.getAllCategoryWithOrNullOutlet)

// drawe header
routerApi.get('/drawer-header', DrawerHeader.getName);

// employee
routerApi.get('/list-employee', Employee.getEmployeeByuserId);
routerApi.delete('/employee-delete', Employee.deleteEmployee);
routerApi.post('/create-employee', Employee.createEmployee);
routerApi.put('/employee-update', Employee.upadteEmployee);
routerApi.get('/employee-by-user', Employee.employeeByUser);

module.exports = routerApi