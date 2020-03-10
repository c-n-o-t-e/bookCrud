pragma solidity >=0.4.22 <0.6.0;


contract BookStoreCrud is BookStoreExternalStorage {
    address owner;
    
    uint public bookList = 0;
    
    mapping (uint => Books) public bookstorage;
    
    struct Books{
        string name;
        string author;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier OnlyOwner() {
        require(msg.sender == owner, "Only contract owner is allowed to call this function");
        _;
    }
    
    function createBook(string memory _bookName, string memory _authorName) internal OnlyOwner {
        bookList += 1;
        Books memory bookFarm;
        bookFarm.name = _bookName;
        bookFarm.author = _authorName;
        bookstorage[bookList] = bookFarm;
    }
    
    function readBook(uint _indexNumber) public view returns(string memory _bookName, string memory _authorName) {
        return (bookstorage[_indexNumber].name, bookstorage[_indexNumber].author);
    }
    
    function deleteBook(uint _indexNumber) public  OnlyOwner  {
        bookList -= 1;
        delete bookstorage[_indexNumber];
    }
    
    function addBook(string memory _bookName, string memory _authorName) public {
        createBook(_bookName, _authorName);
    }
}
