void reduce ( float * vec , float *sum , int size ) {
	float * d_vec ;
	int bytes = size * sizeof ( float ) ;
	
	cudaMalloc (( void **) & d_vec , bytes ) ;
	cudaMemcpy ( d_vec , vec , bytes , cudaMemcpyHostToDevice ) ;
	
	kreduce < < <1 , size > > >( d_vec , size ) ;
	
	cudaMemcpy (sum , d_vec , sizeof ( float ) , cudaMemcpyDeviceToHost ) ;
	cudaFree ( d_vec ) ;
}


__global__
void kreduce(float *d_vec, int size){
	unsigned int tid = threadIdx.x;
	if (tid < size) {
		for (int offset =size/2; offset>0; offset=offset/2){
			if (tid < offset ){
				d_vec[tid]+= d_vec[tid+offset];
			}
			__syncThreads();
		}
	}
}