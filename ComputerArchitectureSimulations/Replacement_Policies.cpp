
#include<bits/stdc++.h>
using namespace std;
void LRU(string Input_File_NameL, int Entry_SizeL)
{
		ifstream file;
		int in=0;
		string Address,Input_File_Name,word;
		Input_File_Name=Input_File_NameL;
		long int comp_miss=0;
		long int capa_miss=0;
		long int tmisses=0;
		int hi=0;
		long int Entry_Size=Entry_SizeL;
		long int acc=0;
		int posi=Input_File_Name.find(".");
		string fname=Input_File_Name.substr(0,posi);
		string roll="19116066";
		string ofname=roll + "_LRU_" + fname + "_" + to_string(Entry_Size) + ".out";
		
		//ofstream Temp("t.txt");
		vector<string> hm;
		string  cache[Entry_Size];
		for(int i=0;i<Entry_Size;i++)
		{
			cache[i]=" ";
		}
		
		vector<string> used;
		file.open(Input_File_Name.c_str());
		if(!file)
		{
			cout<<"file does not exits";
			return;
		}
	    while(file >> Address)
	   {
		   
		  
		   acc++;
		   int hit=0;
		   int indx=-1;
		 for(int i=0;i<Entry_Size;i++)
		 {
			 if(Address== cache[i])
			 {
				 //Temp<<"HIT\n";
				 hm.push_back("HIT");
				 hit=1;
				 indx=i;
				 break;
			 }
		 }
		 if(hit==1)
		 {
			 hi++;
			 if(cache[in]==" " || in==Entry_Size)
				 in--;
			 
			 for(int i=indx;i<Entry_Size-1;i++)
			 {
				 cache[i]=cache[i+1];
			 }
			 cache[in]=Address;
			 in++;
		 }
		 else{
			 tmisses++;
			 hm.push_back("MISS");
			 if(in < Entry_Size)
			 {
				
				 comp_miss++;
				 cache[in]=Address;
				 
				 in++;
				
			 }
			 else{
				
				 int us=0;
				 if(in==Entry_Size)
					 in--;
				 for(int k=0;k<used.size();k++)
				 {
					 if(used[k]==Address)
						 
						 {
							 us=1;
							 break;
						 }
				 }
				 if(us==1)
				 {
					 
					 capa_miss++;
					 used.push_back(cache[0]);
					 for(int j=0;j<Entry_Size-1;j++)
					 {
						 cache[j]=cache[j+1];
					 }
					 cache[Entry_Size-1]=Address;
				 }
				 else{
					  
					 comp_miss++;
					 used.push_back(cache[0]);
					  for(int j=0;j<Entry_Size-1;j++)
					 {
						 cache[j]=cache[j+1];
					 }
					 cache[Entry_Size-1]=Address;
					 
				 }
				 in++;
			 }
		 }
		  	  
		
	   }
	     /*cout<<"TOTAL_ACCESSES = "<<acc<<"\n";
	     //cout<<"TOTAL_HITS = "<<hi<<"\n";
		  cout<<"TOTAL_MISSES = "<<tmisses<<"\n";
		  cout<<"COMPULSORY_MISSES = "<<comp_miss<<"\n";
		  cout<<"CAPACITY_MISSES = "<<capa_miss<<"\n";*/
		 
		  ofstream output;
		  output.open(ofname);
		  if(output.fail())
		  {
			  cout<<"FAiled";
			  return;
		  }
		  else{
		  output<<"TOTAL_ACCESSES = "<<acc<<"\n"
		        <<"TOTAL_MISSES = "<<tmisses<<"\n"
				<<"COMPULSORY_MISSES = "<<comp_miss<<"\n"
				<<"CAPACITY_MISSES = "<<capa_miss<<"\n";
				for(int i=0;i<acc;i++)
					output <<hm[i]<<"\n";
		  }
				
		  
		  output.close();
		  file.close();
		  
		  
		
	   
	   
		
}
void FIFO(string Input_File_NameF,int Entry_SizeF)
{
		ifstream file;
		int in=0;
		string Address,Input_File_Name,word;
		Input_File_Name=Input_File_NameF;
		long int comp_miss=0;
		long int capa_miss=0;
		long int tmisses=0;
		int hi=0;
		long int Entry_Size=Entry_SizeF;
		long int acc=0;
		int posi=Input_File_Name.find(".");
		string fname=Input_File_Name.substr(0,posi);
		string roll="19116066";
		string ofname=roll + "_FIFO_" + fname + "_" + to_string(Entry_Size) + ".out";
		
		
		vector<string> hm;
		string  cache[Entry_Size];
		for(int i=0;i<Entry_Size;i++)
		{
			cache[i]=" ";
		}
		
		vector<string> used;
		file.open(Input_File_Name.c_str());
		if(!file)
		{
			cout<<"file does not exits";
			return;
		}
	    while(file >> Address)
	   {
		   
		  
		   acc++;
		   int hit=0;
		   int indx=-1;
		 for(int i=0;i<Entry_Size;i++)
		 {
			 if(Address== cache[i])
			 {
				 
				 hm.push_back("HIT");
				 hit=1;
				 indx=i;
				 break;
			 }
		 }
		 if(hit==1)
		 {
			 hi++;
			 
		 }
		 else if(hit==0){
			 tmisses++;
			 hm.push_back("MISS");
			 if(in < Entry_Size)
			 {
				
				 comp_miss++;
				 cache[in]=Address;
				 
				 in++;
				
			 }
			 else{
				
				 int us=0;
				 if(in==Entry_Size)
					 in--;
				 for(int k=0;k<used.size();k++)
				 {
					 if(used[k]==Address)
						 
						 {
							 us=1;
							 break;
						 }
				 }
				 if(us==1)
				 {
					 
					 capa_miss++;
					 used.push_back(cache[0]);
					 for(int j=0;j<Entry_Size-1;j++)
					 {
						 cache[j]=cache[j+1];
					 }
					 cache[Entry_Size-1]=Address;
				 }
				 else{
					  
					 comp_miss++;
					 used.push_back(cache[0]);
					  for(int j=0;j<Entry_Size-1;j++)
					 {
						 cache[j]=cache[j+1];
					 }
					 cache[Entry_Size-1]=Address;
					 
				 }
				 in++;
			 }
		 }
		    
		
	   }
	    /* cout<<"TOTAL_ACCESSES = "<<acc<<"\n";
	     //cout<<"TOTAL_HITS = "<<hi<<"\n";
		  cout<<"TOTAL_MISSES = "<<tmisses<<"\n";
		  cout<<"COMPULSORY_MISSES = "<<comp_miss<<"\n";
		  cout<<"CAPACITY_MISSES = "<<capa_miss<<"\n";*/
		 
		  ofstream output;
		  output.open(ofname);
		  if(output.fail())
		  {
			  cout<<"FAiled";
			  return;
		  }
		  else{
		  output<<"TOTAL_ACCESSES = "<<acc<<"\n"
		        <<"TOTAL_MISSES = "<<tmisses<<"\n"
				<<"COMPULSORY_MISSES = "<<comp_miss<<"\n"
				<<"CAPACITY_MISSES = "<<capa_miss<<"\n";
				for(int i=0;i<acc;i++)
					output <<hm[i]<<"\n";
		  }
				
		  
		  output.close();
		  file.close();
}
void OPTIMAL(string Input_File_NameO, int Entry_SizeO)
{
		ifstream file;
		int in=0;
		string Address,Input_File_Name,word;
		Input_File_Name=Input_File_NameO;
		long int comp_miss=0;
		long int capa_miss=0;
		long int tmisses=0;
		int hi=0;
		long int Entry_Size=Entry_SizeO;
		long int acc=0;
		int posi=Input_File_Name.find(".");
		string fname=Input_File_Name.substr(0,posi);
		string roll="19116066";
		string ofname=roll + "_OPTIMAL_" + fname + "_" + to_string(Entry_Size) + ".out";
		
		vector<string> hm;
		vector<string> inputs;
		string  cache[Entry_Size];
		
		for(int i=0;i<Entry_Size;i++)
		{
			cache[i]=" ";
		}
		
		vector<string> used;
		file.open(Input_File_Name.c_str());
		if(!file)
		{
			cout<<"file does not exits";
			return;
		}
	    while(file >> Address)
	   {
		   
		   inputs.push_back(Address);
	   }
	  
	   for(int y=0;y<inputs.size();y++)
	   {
		   acc++;
		   int hit=0;
		   int indx=-1;
		 for(int i=0;i<Entry_Size;i++)
		 {
			 if(inputs[y]== cache[i])
			 {
				 //Temp<<"HIT\n";
				 hm.push_back("HIT");
				 hit=1;
				 indx=i;
				 break;
			 }
		 }
		 if(hit==1)
		 {
			 hi++;
			 
		 }
		 else if(hit==0){
			 tmisses++;
			 hm.push_back("MISS");
			 if(in < Entry_Size)
			 {
				
				 comp_miss++;
				 cache[in]=inputs[y];
				 
				 in++;
				
			 }
			 else{
				
				 int us=0;
				 
				 for(int k=0;k<used.size();k++)
				 {
					 if(used[k]==inputs[y])
						 
						 {
							 us=1;
							 break;
						 }
				 }
				 if(us==1)
				 {
					 
					 capa_miss++;
					 
					 
				 }
				 else{
					  
					 comp_miss++;
					 }
				    long int  far=-1;
					 long int rep=-1;
					 int ok=0;
					  
					 for(int j=0;j<Entry_Size;j++)
					 {
						
						 int dx=-1;
						 for(int q=acc-1;q<inputs.size();q++)
						 {
							 if(cache[j]==inputs[q])
							 {
								 dx=q;
								 break;
							 }
						 }
					 if(dx==-1)
					 {
						 rep=j;
						 break;
					 }
					 else{
						 if(dx > far)
						 {
							 far=dx;
							 rep=j;
						 }
					 }
					
					
					 
					 }
					 used.push_back(cache[rep]);
					 cache[rep]=inputs[y];
			 }
		 }
		
		}
	      /*cout<<"TOTAL_ACCESSES = "<<acc<<"\n";
	      //cout<<"TOTAL_HITS = "<<hi<<"\n";
		  cout<<"TOTAL_MISSES = "<<tmisses<<"\n";
		  cout<<"COMPULSORY_MISSES = "<<comp_miss<<"\n";
		  cout<<"CAPACITY_MISSES = "<<capa_miss<<"\n";*/
		  
		  
		  ofstream output;
		  output.open(ofname);
		  if(output.fail())
		  {
			  cout<<"FAiled";
			  return;
		  }
		  else{
		  output<<"TOTAL_ACCESSES = "<<acc<<"\n"
		        <<"TOTAL_MISSES = "<<tmisses<<"\n"
				<<"COMPULSORY_MISSES = "<<comp_miss<<"\n"
				<<"CAPACITY_MISSES = "<<capa_miss<<"\n";
				for(int i=0;i<acc;i++)
					output <<hm[i]<<"\n";
		  }
				
		  
		   file.close();
		  output.close();
		  
}
int main(int argc, char **argv)
{
	//Declaring all variables:

	string R_Policy,Input_File_Name,Address;
	int Entry_Size;
	//Taking input in order binary policy inputfilename cache_entrysize
	R_Policy=argv[1];
	Input_File_Name=argv[2];
	Entry_Size=stoi(argv[3]);
	
	//Implementing according to policy of replacement:
	if(R_Policy=="LRU")
	{
		LRU(Input_File_Name,Entry_Size);
	}
	else if(R_Policy=="FIFO")
	{
			FIFO(Input_File_Name,Entry_Size);
	}
	else if(R_Policy=="OPTIMAL")
	{
			OPTIMAL(Input_File_Name,Entry_Size);
	}


	

}
