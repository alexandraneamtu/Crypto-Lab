//
//  main.cpp
//  Crypto_lab4
//
//  Created by Alexandra Neamtu on 06/12/2017.
//  Copyright © 2017 Alexandra Neamtu. All rights reserved.
//

#include <iostream>
#include <cmath>
#include <chrono>
using namespace std;

typedef std::chrono::high_resolution_clock Clock;


void printPolynom(long *P, long len){
    for (long i = 0; i < len; i++)
    {
        std::cout<<(P[i]);
        if (i != 0)
        std::cout<<"*x^"<<i;
        if (i != len - 1)
        std::cout<<" + ";
    }
    std::cout<<'\n';
}


long gcd(long a, long b){
    long r;
    while (b != 0){
        r = a % b;
        a = b;
        b = r;
    }
    return a;
}

void classicAlgorithm(long n){
    long x0 = 3;
    long count = 0;
    long initialn =n;
    long factors=0;
    cout<<endl;
    cout<<"------Classical algorithm------"<<endl;
    auto start = Clock::now();
    while(n > 1 && x0 < initialn){
        while(n % x0 == 0){
            count++;
            n = n / x0;
        }
        if(count>0){
            cout<<"A factor of n is "<<x0<<"^"<<count<<endl;
            count = 0;
            factors++;
        }
        x0 = x0 + 2;
    }
    
    auto end = Clock::now();
    if(factors == 0){
        cout<<"FAILURE"<<endl;
    }
    auto time = (end-start);
    std::cout << "Execution Time: ";
    std::cout << (std::chrono::duration_cast<std::chrono::milliseconds>(time)).count() << " milliseconds" << '\n';
    cout<<endl;
    
}


long polynomialOf(long *p,long degree, long x, long n){
    long result = 0;
    long aux=0;
    for(long i=0; i< degree+1; i++){
        aux = pow(x,i);
        result = result + p[i]*aux;
        if(result>=n){
            result = result%n;
        }
    }
    return result;
}

bool pollardAlgorithm(long *p,long degree, long n,long value){
    
    long x[1000000]; long d=0;
    long limit = 1000000;
    x[0]=value;
    
    for(long i=1;i<limit;i=i+2){
        x[i] = polynomialOf(p,degree, x[i-1], n);
        x[i+1] = polynomialOf(p,degree, x[i], n);
        
        
        d = gcd(abs(x[i+1]-x[i-1]),n);
    
        
        if(d>1 and d<n){
            cout<<"A nontrivial factor of n is: "<<d<<endl;
            return true;
        
        }
        
    
        if(d==n){
            cout<<"FAILURE"<<endl;
            return false;
        }
    }
    
    cout<<"Not found any factor"<<endl;
    return true;
}




int main(int argc, const char * argv[]) {
    long n,degree,coeff;
    cout<<"number:";
    cin>>n;
    if(n%2 == 0){
        cout<<"The number must be odd";
        return 0;
    }
    cout<<"degree of the polynomial:";
    cin>>degree;
    
    long polynomial[degree+1];
    for (int i=0;i<degree+1;i++){
        cout<<"x^"<<i<<": ";
        cin>>coeff;
        polynomial[i] = coeff;
    }
    
    printPolynom(polynomial,degree+1);
    classicAlgorithm(n);

    cout<<"------Pollard's p algorithm------"<<endl;
    
    long value = 2;
    cout<<"x0="<<value<<endl;
    auto start = Clock::now();
    bool test = pollardAlgorithm(polynomial,degree,n,value);
    while(test == false && value<20){
        value ++;
        cout<<"x0="<<value<<endl;
        test = pollardAlgorithm(polynomial,degree,n,value);
    }
    auto end = Clock::now();
    auto time = (end-start);
    std::cout << "Execution Time: ";
    std::cout << (std::chrono::duration_cast<std::chrono::milliseconds>(time)).count() << " milliseconds" << '\n';
    
    //computeAlg(polynomial, n, 2);
    
    return 0;
}




/*
 long pollardAlgorithm(long *p, long n,long value){
 //bool first=true;
 
 cout<<endl;
 cout<<"------Pollard's p algorithm------"<<endl;
 long x[100000]; long d=0;
 long limit = 100000;
 x[0]=value;
 auto start = Clock::now();
 for(long i=1;i<limit;i=i+2){
 //cout<<"i: "<<i<<endl;
 x[i] = polynomialOf(p, x[i-1], n);
 x[i+1] = polynomialOf(p, x[i], n);
 //cout<<"x1: "<<x[i]<<endl;
 //cout<<"x2: "<<x[i+1]<<endl;
 
 d = gcd(abs(x[i+1]-x[i-1]),n);
 //cout<<"D: "<<d;
 
 if(d>1 and d<n){
 cout<<"A nontrivial factor of n is: "<<d<<endl;
 //pollardAlgorithm(p, n/d, value);
 return d;
 //n = n/d;
 //d=0;
 //i=-1;
 //cout<<n;
 //first=false;
 }
 
 //if(d==n and first==true){
 //cout<<"FAILURE";
 //break;
 //}
 //if(d==n and first==false){
 //cout<<d<<endl;
 //break;
 //
 
 if(d==n){
 cout<<"FAILURE"<<endl;
 return 1;
 }
 }
 return -1;
 auto end = Clock::now();
 auto time = (end-start);
 std::cout << "Execution Time: ";
 std::cout << (std::chrono::duration_cast<std::chrono::milliseconds>(time)).count() << " milliseconds" << '\n';
 cout<<endl;
 
 }
 
 
 void computeAlg(long *p, long n,long value){
 bool first =true;
 long test = pollardAlgorithm(p,n,value);
 long newValue = n;
 cout<<"test: "<<test<<endl;
 while(test !=  1 and test != -1 and value<20){
 newValue = n/test;
 cout<<"newN: "<<newValue<<endl;
 test = pollardAlgorithm(p, newValue, value);
 first = false;
 }
 while(test == -1 and value<20){
 if(first==false){
 cout<<"2ndcase: "<<endl;
 test = pollardAlgorithm(p, newValue, value++);
 if(test == 1){
 cout<<"A nontrivial factor of n is: "<<newValue;
 }
 }
 else{
 test = pollardAlgorithm(p, newValue, value++);
 }
 }
 }
 */
