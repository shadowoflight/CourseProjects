
#include <bits/stdc++.h>
using namespace std;
string getIntegerVal(string s,int T,int E) // 1 sign bit and T-1 mnatissa bit
{
 /*long int val=0;
 int ct=s.length()-1;
 for(int i=s.length()-1;i>0;i--)
 {
 	int x=s[i]-'0';
 	val=val+x*pow(2,ct-i);
 }*/
 string temp=s.substr(1,T-1);
	int val= stoi(temp,0,2);
 string ans=to_string(val);
 if(s[0]=='1' && val !=0)
 	ans="-"+ans;
 else
 	ans=ans;
 return ans;
}
string getFixedPoint(string s,int T, int E) // 1 sign bit and E integer bits and T-1-E fraction bit
{
	int Th=T;
	int Eh=E;
long int in=0;
float frac=(float)0;
/*for(int i=1;i<=Eh;i++)
{
	int x=s[i]-'0';
	in=in+x*pow(2,Eh-i);
}*/
string temp=s.substr(1,Eh);
in=stoi(temp,0,2);

/*for(int i=Eh+1;i<s.length();i++)
{
 int x=s[i]-'0';
 frac=frac+(((double)x)/((double)pow(2,i-Eh)));
}*/
string temp2=s.substr(Eh+1,Th-Eh-1);
int ft=stoi(temp2,0,2);
frac=(float)(((float)ft)/((float)pow(2,Th-Eh-1)));
 float ans=in+(float)frac;
ostringstream os;
os<< ans;
string anss=os.str();
if(s[0]=='1' && ans !=(float)0)
	anss='-'+anss;
return anss;
}
string getFP(string s,int T,int E) // 1 sign bit and E exponent bits and T-1-E mantissa bit
{
	int Th=T;
	int Eh=E;
 bool nan = 0;
 bool infi=0;
 int cte=0;
 int ctf=0;
 int dn=0;
 string anss;
 for(int i=1;i<=Eh;i++)
 {
 	if(s[i]=='1')
 		cte++;
 	else if(s[i]=='0')
 		dn++;
 }
 for(int i=Eh+1;i<s.length();i++)
 {
 	if(s[i]=='0')
 		ctf++;
 }
 if(cte== Eh && ctf == (Th-1-Eh))
 {
 	anss="infinity";
 	if(s[0]=='1')
	anss='-'+anss;
else
	anss='+'+anss;
 }
 else if(cte == Eh && ctf != (Th-1-Eh))
 	anss="NAN";
 else if(dn==Eh && ctf==(Th-1-Eh))
 	anss="0";
 else if(dn==Eh && ctf <(Th-1-Eh))
 {
  int bias = pow(2,Eh-1)-1;
  int expo= 1-bias;
  float frac=0;
  for(int i=Eh+1;i<s.length();i++)
{
 int x=s[i]-'0';
 frac=(float)(frac+(((float)x)/((float)pow(2,i-Eh))));
}
float ans = (float)frac*pow(2,expo);
//cout<<setprecision(Th-Eh)<<ans;
ostringstream os;
os<<ans;
anss=os.str();
if(s[0]=='1' && ans!= 0)
	anss='-'+anss;
anss="    Denormal number "+anss;

 }
 else
 {
 	int bias = pow(2,Eh-1)-1;
 	long int in=0;
float frac=0;
for(int i=1;i<=Eh;i++)
{
	int x=s[i]-'0';
	in=in+x*pow(2,Eh-i);
}
for(int i=Eh+1;i<s.length();i++)
{
 int x=s[i]-'0';
 frac=(float)(frac+(((float)x)/((float)pow(2,i-Eh))));
}
 
 	int expo=in-bias;
 	float ans=(float)(1+(float)frac)*(pow(2,expo));
 	//cout<<setprecision(Th-1-Eh)<<ans;
 	ostringstream os;
os<<ans;
anss=os.str();
if(s[0]=='1' and ans!=0)
	anss='-'+anss;

 }
 
 return anss;
}
int main(int argc,char **argv)
{
	int T=stoi(argv[1]);
	int E=stoi(argv[2]);
	string s =argv[3];
	string name="19116066_"+to_string(T)+"_"+to_string(E)+"_"+s;
	if(s!="All")
	{
		name=name+"_"+argv[4]+".txt";
		string snum=argv[4];
	ofstream output;
	output.open(name);
	if(output.fail())
	{
		cout<<"Failed";
		return 0;
	}
	else
	{
		output<<"combinations"<<setw(20)<<"integer"<<setw(20)<<"fixed point"<<setw(20)<<"FP"<<"\n";
	output<<snum<<setw(20)<<getIntegerVal(snum,T,E)<<setw(20)<<getFixedPoint(snum,T,E)<<setw(20)<<getFP(snum,T,E)<<"\n";
    }
    output.close();
    }
   else
    {
    	name=name+".txt";
    ofstream output;
	output.open(name);
	  if(output.fail())
	  {
		cout<<"Failed";
		return 0;
	  }  
	  else
	  {
          output<<"combinations"<<setw(20)<<"integer"<<setw(20)<<"fixed point"<<setw(20)<<"FP"<<"\n";
		for(int i=0;i<pow(2,T-1);i++)
		{
         string binn="";
         int k=i;
         while(k>0)
        {
        	int rem=k%2;
        	k=k/2;
        	binn=to_string(rem)+binn;
        }
        while(binn.length() <T-1)
        {
        	binn='0'+binn;
        }
        binn="0"+binn;

	        output<<binn<<setw(20)<<getIntegerVal(binn,T,E)<<setw(20)<<getFixedPoint(binn,T,E)<<setw(20)<<getFP(binn,T,E)<<"\n";
        }
        for(int i=0;i<pow(2,T-1);i++)
		{
         string binp="";
         int kp=i;
         while(kp>0)
        {
        	int rem=kp%2;
        	kp=kp/2;
        	binp=to_string(rem)+binp;
        }
        while(binp.length() <T-1)
        {
        	binp='0'+binp;
        }
        binp="1"+binp;
	        output<<binp<<setw(20)<<getIntegerVal(binp,T,E)<<setw(20)<<getFixedPoint(binp,T,E)<<setw(20)<<getFP(binp,T,E)<<"\n";
        }
    
           output.close();
        }
	  }
    
  
}
