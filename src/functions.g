function make_synapse(pre,post,weight,delay)
 str pre,post
 float weight,delay
 int syn_num
        
   addmsg {pre} {post} SPIKE
   syn_num = {getfield {post} nsynapses} - 1
   setfield {post} synapse[{syn_num}].weight {weight} \
                   synapse[{syn_num}].delay {delay} 
   //echo {pre} "--->" {post} {weight} {delay}
                   
end



// reception field for retina
//
// protocell - cell prototype
// net - neural network
// px, py - macro-position of the reception field
// w, h - size of the reception field (in cells)
function make_retina_reception_field(protocell, net, px, py, w, h)
int i, j

for (i=1; i<={w};i={i+1})
    for (j=1; j<={h};j={j+1})
   
      copy {protocell} {net}_retina_{px}_{py}_{i}_{j} 
 
      position {net}_retina_{px}_{py}_{i}_{j} \
            { {px} * {w} + ({sep_x} * {i}) } \
            { {py} * {h} + ({sep_y} * {j}) } \
            0
    end
  end

echo reception field {w} x {h} at [{px},{py}]
end


// cortical column
//
// protocell - cell prototype
// net - neural network
// px, py - macro-position (same as related reception field)
// w, h, d - size of the reception field (in cells)
function make_cortical_column(protocell, net, px, py, w, h, d)
int i, j, k

for (i=1; i<={w};i={i+1})
    for (j=1; j<={h};j={j+1})
        for (k=1; k<={d};k={k+1})

            copy {protocell} {net}_cortex_{px}_{py}_{i}_{j}_{k} 
        
            position {net}_cortex_{px}_{py}_{i}_{j}_{k} \       // cortical columns are not placed directly above reception fields with this approach
                    { {px} * {w} + ({sep_x} * {i}) } \
                    { {py} * {h} + ({sep_y} * {j}) } \
                    { 0 + ({sep_z} * {k}) } 
        end
    end
  end

echo cortical column {w} x {h} x {d} at [{px},{py}]
end


// create connection within the cortical column
//
function wire_cortical_column (net, px, py, w, h, d, probability)
int i1,j1,k1,i2,j2,k2

echo wireing cortical column {px},{py} with probability = {probability}


for (i1=1; i1<={w}; i1={i1+1})
 for (j1=1; j1<={h}; j1={j1+1})
  for (k1=1; k1<={d}; k1={k1+1})
   for (i2=1; i2<={w}; i2={i2+1})
     for (j2=1; j2<={h}; j2={j2+1})
      for (k2=1; k2<={d}; k2={k2+1})      

       if ( {rand 0 1} < {probability} )            
        make_synapse {net}_cortex_{px}_{py}_{i1}_{j1}_{k1}/soma/spike \
                     {net}_cortex_{px}_{py}_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end
            
      end
     end 
    end
  end
 end
end


end


// connect retina reception field to the cortical column
//
function connect_reception_field_to_column (net, px, py, rw, rh, w, h, d, probability)
int i1,j1,i2,j2,k2

echo connecting retina {px},{py} to its column with probability = {probability}

for (i1=1; i1<={rw}; i1={i1+1})
 for (j1=1; j1<={rh}; j1={j1+1})
  
   for (i2=1; i2<={w}; i2={i2+1})
     for (j2=1; j2<={h}; j2={j2+1})
      for (k2=1; k2<={d}; k2={k2+1})      

       if ( {rand 0 1} < {probability} )            
        make_synapse {net}_retina_{px}_{py}_{i1}_{j1}/soma/spike \
                     {net}_cortex_{px}_{py}_{i2}_{j2}_{k2}/dend/Ex_channel 3.8 0
       end
            
      end
     end 
    
  end
 end
end


end

// create output measuremnts
//
function create_random_output(net, w, h, d, filename)
int x = {rand 1 {w}+1}
int y = {rand 1 {h}+1}
int z = {d}

int i,j

// for every column
for (i=1; i<=2 ; i={i+1})
  for (j=1; j<=2 ; j={j+1})

    // only spikes
    //addmsg {net}_cortex_{i}_{j}_{x}_{y}_{z}/soma/spike {net}-history SPIKESAVE
    
    // soma potential
    create asc_file /output_{i}_{j}
    useclock /output_{i}_{j} 0
    setfield /output_{i}_{j} filename {filename}_{i}_{j}.vm append 0
    addmsg {net}_cortex_{i}_{j}_{x}_{y}_{z}/soma /output_{i}_{j} SAVE Vm


  end
end

echo outputs from [{x},{y},{z}] cell of every cortical column

end
